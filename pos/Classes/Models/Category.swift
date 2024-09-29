//
//  Category.swift
//  pos
//
//  Created by Brian Chou on 2024/9/15.
//

import FirebaseFirestore
import Foundation

public struct Category: Codable, Identifiable, Hashable {
    @DocumentID public var id: String?
    let name: String
}
