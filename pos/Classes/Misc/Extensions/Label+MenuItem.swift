//
//  Label+MenuItem.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import SwiftUI

extension Label where Title == Text, Icon == Image {
    init(item: MenuItem) {
        switch item {
        case .checkout:
            self.init("結帳", systemImage: "tray.full")

        case .transactions:
            self.init("交易紀錄", systemImage: "rectangle.and.text.magnifyingglass")

        case .orders:
            self.init("訂單", systemImage: "bag.badge.plus")

        case .reports:
            self.init("報表", systemImage: "chart.line.uptrend.xyaxis")

        case .items:
            self.init("商品管理", systemImage: "tag")

        case .customers:
            self.init("顧客管理", systemImage: "person.text.rectangle")

        case .settings:
            self.init("設定", systemImage: "gearshape")

        case .logout:
            self.init("切換使用者", systemImage: "rectangle.portrait.and.arrow.right")
        }
    }
}
