//
//  TransactionsViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/10/29.
//

import FirebaseFirestore
import Foundation
import SwiftUI

class TransactionsViewModel: ObservableObject {
    @Published var transactions: [Transaction] = []
    @Published var isEndOfList = false
    @Published var listLoadingState: ListLoadingState = .success(count: 0)
    private let db = DBService.shared
    private var transactionQuery: Query?

    init() {
        do {
            transactionQuery = try DBService.shared.getTransactionListQuery(limit: 10)
        } catch {
            print(error)
        }
    }

    func getTransactionList() {
        print("getShoppingList \(listLoadingState)")
        listLoadingState = .loading(count: transactions.count)

        transactionQuery?.addSnapshotListener { [weak self] snapshot, error in
            guard let self = self else { return }
            guard let snapshot = snapshot else {
                print("Error retreving cities: \(error.debugDescription)")
                return
            }

            guard let lastSnapshot = snapshot.documents.last else {
                // The collection is empty.
                self.isEndOfList = true
                print("No more transactions")
                return
            }

            do {
                let newTransactions = try snapshot.documents.compactMap { try $0.data(as: Transaction.self) }
                for transaction in newTransactions {
                    let filterNewTransactionsResult = self.transactions.filter { $0.id == transaction.id }
                    if filterNewTransactionsResult.isEmpty && transaction.id != nil {
                        self.transactions.append(transaction)
                    }
                }
                self.listLoadingState = .success(count: transactions.count)
                self.isEndOfList = false
            } catch {
                print(error.localizedDescription.debugDescription)
                self.listLoadingState = .fail(error: error.localizedDescription.debugDescription)
            }

            do {
                self.transactionQuery = try db.getTransactionListQuery(limit: 10).start(afterDocument: lastSnapshot)
            } catch {
                print(error)
            }
        }
    }
}

enum ListLoadingState: Equatable {
    case loading(count: Int)
    case success(count: Int)
    case fail(error: String)
}
