//
//  Item.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import FirebaseFirestore
import Foundation

public struct Item: Codable, Identifiable, Hashable {
    @DocumentID public var id: String?
    let name: String
    let price: Double
    var imageKey: String
    var imageUrl: String
    let categoryID: String
}
