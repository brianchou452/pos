//
//  Item.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import Foundation

// import UIKit

public struct Item: Codable {
    let name: String
    let price: Double
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case name
        case price
        case imageUrl = "image"
    }
}
