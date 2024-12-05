//
//  MenuItem.swift
//  pos
//
//  Created by Brian Chou on 2023/11/27.
//

enum MenuItem: Identifiable, CaseIterable, Hashable {
    static var allCases = [
        checkout,
        transactions,
        orders(orderId: nil),
        reports,
        items,
        customers,
        settings,
        .logout
    ]

    case checkout
    case transactions
    case orders(orderId: String?)
    case reports
    case items
    case customers
    case settings
    case logout

    var id: Int {
        switch self {
        case .checkout: return 0
        case .transactions: return 1
        case .orders: return 2
        case .reports: return 3
        case .items: return 4
        case .customers: return 5
        case .settings: return 6
        case .logout: return 7
        }
    }
}
