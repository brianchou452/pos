//
//  DBService.swift
//  pos
//
//  Created by Brian Chou on 2024/9/15.
//

import FirebaseCore
import FirebaseFirestore
import Foundation

class DBService: ObservableObject {
    private let db = Firestore.firestore()
    private let authService = AuthService.shared
    static let shared = DBService()
    var newOrder: Order?

    init() {
        #if DEBUG
//        let settings = Firestore.firestore().settings
//        settings.host = "192.168.1.192:8081"
//        settings.cacheSettings = MemoryCacheSettings()
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
        UserDefaults.storeID = "6LF5tEtVTzzNm3J2rTrR"
        #endif
        try? getOrders()
    }

    func save(user: User, uid: String?) {
        guard let uid = uid else { return }
        do {
            let ref = db.collection(Collections.users).document(uid)
            try ref.setData(from: user)
            print("User successfully updated")
        } catch {
            print("error in saving user \(error)")
        }
    }

    func add(item: Item) throws -> String {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        let ref = try db.collection(Collections.stores).document(storeID)
            .collection(Collections.menus).addDocument(from: item)
        return ref.documentID
    }

    func add(category: Category) throws -> String {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        let ref = try db.collection(Collections.stores).document(storeID)
            .collection(Collections.categories).addDocument(from: category)
        return ref.documentID
    }

    func add(store: Store) throws -> String {
        var storeWithUid = store
        storeWithUid.owners.append(authService.user.userID)

        let ref = try db.collection(Collections.stores).addDocument(from: storeWithUid)
        return ref.documentID
    }

    func add(transaction: Transaction) throws -> String {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        let ref = try db.collection(Collections.stores).document(storeID)
            .collection(Collections.transactions).addDocument(from: transaction)
        return ref.documentID
    }

    func getItemsQuery() throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.menus)
    }

    func getCategoriesQuery() throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.categories)
    }

    func getTransactionListQuery(limit: Int) throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.transactions)
            .order(by: "createdAt", descending: true)
            .limit(to: limit)
    }

    func getOrderListQuery(limit: Int) throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.orders)
            .order(by: "createdAt", descending: true)
            .limit(to: limit)
    }

    func getOrders() throws {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        db.collection(Collections.stores).document(storeID)
            .collection(Collections.orders)
            .order(by: "createdAt", descending: true)
            .limit(to: 1)
            .addSnapshotListener { [weak self] querySnapshot, _ in
                guard let documents = querySnapshot?.documents,
                      let self = self
                else {
                    print("getOrders() Error fetching documents")
                    return
                }
                do {
                    let newOrders = try documents.compactMap { try $0.data(as: Order.self) }
                    if newOrders.count > 0 {
                        guard let order = newOrders.first else { return }
                        if self.newOrder != nil {
                            NotificationService.shared.sendNewOrderNotification(order: order)
                        }
                        self.newOrder = order
                    }
                } catch {
                    print("getOrders() \(error.localizedDescription)")
                    print("getOrders() \(dump(error))")
                    return
                }
            }
    }
}

enum Collections {
    static let users = "users"
    static let stores = "stores"
    static let menus = "menus"
    static let orders = "orders"
    static let categories = "categories"
    static let transactions = "transactions"
}

enum DBServiceError: Error {
    case storeIdNotFound
    case firebaseError(Error)
}
