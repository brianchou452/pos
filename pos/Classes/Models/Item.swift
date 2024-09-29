//
//  Item.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import FirebaseFirestore
import Foundation

public struct Item: Codable, Identifiable {
    @DocumentID public var id: String?
    let name: String
    let price: Double
    let imageUrl: String
    let categoryID: String
}
