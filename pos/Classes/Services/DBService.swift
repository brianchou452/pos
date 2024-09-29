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

//    init() {
//        let settings = Firestore.firestore().settings
//        settings.host = "192.168.1.163:8080"
//        settings.cacheSettings = MemoryCacheSettings()
//        settings.isSSLEnabled = false
//        Firestore.firestore().settings = settings
//    }

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
            .collection(Collections.categorise).addDocument(from: category)
        return ref.documentID
    }

    func add(store: Store) throws -> String {
        var storeWithUid = store
        storeWithUid.owners.append(authService.user.userID)

        let ref = try db.collection(Collections.stores).addDocument(from: storeWithUid)
        return ref.documentID
    }

    func getItemsQuery() throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.menus)
    }

    func getCategoriseQuery() throws -> Query {
        guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
        return db.collection(Collections.stores).document(storeID)
            .collection(Collections.categorise)
    }
}

enum Collections {
    static let users = "users"
    static let stores = "stores"
    static let menus = "menus"
    static let categorise = "categorise"
}

enum DBServiceError: Error {
    case storeIdNotFound
    case firebaseError(Error)
}
