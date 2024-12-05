//
//  Order.swift
//  pos
//
//  Created by Brian Chou on 2024/12/2.
//

import FirebaseFirestore
import Foundation

struct Order: Codable, Identifiable {
    @DocumentID public var id: String?
    let user: User
    let items: [CartItem]
    let total: Double
    let status: String
    let paymentMethod: String
    let createdAt: Date
    let updatedAt: Date

    init(user: User, items: [CartItem], total: Double) {
        self.user = user
        self.items = items
        self.total = total
        self.createdAt = Date()
        self.updatedAt = Date()
        self.status = Status.pending.rawValue
        self.paymentMethod = PaymentMethod.unPaid.rawValue
    }
}

extension Order {
    enum Status: String {
        case pending
        case preparing
        case completed
    }

    enum PaymentMethod: String {
        case cash
        case creditCard
        case unPaid
    }
}
