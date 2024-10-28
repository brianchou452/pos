//
//  CartView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/1.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var viewModel: CheckoutViewModel

    var body: some View {
        VStack(alignment: .center) {
            List {
                ForEach(viewModel.shoppingCart) { item in
                    CartItemView(item: item,
                                 onRemove: { item in
                                     viewModel.removeItemFromCart(item: item)
                                 }, onAdd: { item in
                                     viewModel.addItemToCart(item: item)
                                 })
                }
            }
            .background(Color.clear)

            Button("Checkout") {
                viewModel.shoppingCart.removeAll()
            }
            .buttonStyle(.bordered)
            .padding()
            .alignmentGuide(.bottom) { $0[.bottom] - 100 }
        }
        .frame(maxWidth: 350)
    }
}

#Preview {
    CartView()
        .environmentObject(CheckoutViewModel())
}
