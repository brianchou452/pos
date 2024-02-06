//
//  MenuItem.swift
//  pos
//
//  Created by Brian Chou on 2023/11/27.
//

enum MenuItem: Identifiable, CaseIterable {
    case checkout
    case transactions
    case orders
    case reports
    case items
    case customers
    case settings
    case logout

    var id: Int { hashValue }
}
