//
//  Store.swift
//  pos
//
//  Created by Brian Chou on 2024/9/16.
//

import FirebaseFirestore
import Foundation

public struct Store: Codable {
    @DocumentID public var id: String?
    let name: String
    var editors: [String] = []
    var owners: [String] = []

    enum CodingKeys: String, CodingKey {
        case name
        case editors
        case owners
    }
}
