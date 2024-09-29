//
//  ItemsSettings.swift
//  pos
//
//  Created by Brian Chou on 2024/4/23.
//

import Foundation

enum ItemsSettings: String, Identifiable, CaseIterable {
    case items = "商品"
    case category = "類別"
    case sets = "套餐/組合"
    case modifiers = "商品選項"
    case discounts = "折扣"

    var id: String { UUID().uuidString }
}
