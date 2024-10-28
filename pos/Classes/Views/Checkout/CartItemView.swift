//
//  CartItemView.swift
//  pos
//
//  Created by Brian Chou on 2024/10/7.
//

import SwiftUI

struct CartItemView: View {
    let item: CartItem
    let onRemove: (CartItem) -> Void
    let onAdd: (CartItem) -> Void

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text("\(item.quantity) x \(item.price.formatted(.currency(code: "TWD")))")
                    .font(.subheadline)
            }

            Spacer()

            Stepper {} onIncrement: {
                onAdd(item)
            } onDecrement: {
                onRemove(item)
            }
            .padding(5)
        }
    }
}
