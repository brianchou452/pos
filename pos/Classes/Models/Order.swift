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
    let status: Status
    let paymentMethod: PaymentMethod
    let createdAt: Date
    let updatedAt: Date

    init(user: User, items: [CartItem], total: Double) {
        self.user = user
        self.items = items
        self.total = total
        self.createdAt = Date()
        self.updatedAt = Date()
        self.status = .pending
        self.paymentMethod = .unPaid
    }
}

extension Order {
    enum Status: String, Codable {
        case pending
        case preparing
        case completed
    }

    enum PaymentMethod: String, Codable {
        case cash
        case creditCard
        case unPaid
    }
}
