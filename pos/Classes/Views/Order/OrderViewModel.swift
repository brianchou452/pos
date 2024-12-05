//
//  OrderViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/12/2.
//

import FirebaseFirestore
import Foundation
import SwiftUI

class OrderViewModel: ObservableObject {
    @Published var orders: [Order] = []
    @Published var isEndOfList = false
    @Published var listLoadingState: ListLoadingState = .success(count: 0)
    private let db = DBService.shared
    private var orderQuery: Query?
    
    init() {
        do {
            orderQuery = try DBService.shared.getOrderListQuery(limit: 10)
        } catch {
            print(error)
        }
    }
    
    func getOrderList() {
        print("getOrderList \(listLoadingState)")
        listLoadingState = .loading(count: orders.count)
        
        orderQuery?.addSnapshotListener { [weak self] snapshot, error in
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
                let newOrders = try snapshot.documents.compactMap { try $0.data(as: Order.self) }
                self.orders.append(contentsOf: newOrders)
                self.listLoadingState = .success(count: orders.count)
                self.isEndOfList = false
            } catch {
                print(error.localizedDescription.debugDescription)
                self.listLoadingState = .fail(error: error.localizedDescription.debugDescription)
            }
            
            do {
                self.orderQuery = try db.getOrderListQuery(limit: 10).start(afterDocument: lastSnapshot)
            } catch {
                print(error)
            }
        }
    }
}
