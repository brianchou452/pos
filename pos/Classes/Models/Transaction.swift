//
//  Transaction.swift
//  pos
//
//  Created by Brian Chou on 2024/10/28.
//

import FirebaseFirestore
import Foundation

struct Transaction: Codable, Identifiable {
    @DocumentID public var id: String?
    let user: User
    let items: [CartItem]
    let total: Double
    let createdAt: Date
    let updatedAt: Date

    init(user: User, items: [CartItem], total: Double) {
        self.user = user
        self.items = items
        self.total = total
        self.createdAt = Date()
        self.updatedAt = Date()
    }
}
