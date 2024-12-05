//
//  CartItem.swift
//  pos
//
//  Created by Brian Chou on 2024/10/7.
//

import Foundation

public struct CartItem: Codable, Identifiable, Hashable {
    public let id: String?
    let name: String
    let price: Double
    var imageKey: String
    let imageUrl: String
    let categoryID: String
    var quantity: Int

    init(item: Item, quantity: Int = 1) {
        self.id = item.id
        self.name = item.name
        self.price = item.price
        self.imageUrl = item.imageUrl
        self.categoryID = item.categoryID
        self.quantity = quantity
        self.imageKey = item.imageKey
    }
}
