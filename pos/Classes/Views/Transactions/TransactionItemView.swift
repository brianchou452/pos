//
//  TransactionItemView.swift
//  pos
//
//  Created by Brian Chou on 2024/11/2.
//

import SwiftUI

struct TransactionItemView: View {
    let item: CartItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("\(item.quantity) x \(item.price.formatted(.currency(code: "TWD")))")
                    .font(.subheadline)
            }
            Spacer()
            Text((item.price * Double(item.quantity)).formatted(.currency(code: "TWD")))
                .font(.headline)
        }
    }
}
