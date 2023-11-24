//
//  Item.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
