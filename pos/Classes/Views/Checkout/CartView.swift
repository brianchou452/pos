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
                                 .swipeActions(content: {
                                     Button(action: {
                                         viewModel.removeItemFromCart(item: item, clearAll: true)
                                     }) {
                                         Image(systemName: "trash.fill")
                                             .foregroundColor(.white)
                                     }
                                     .tint(Color.red)
                                 })
                }
            }
            .background(Color(.systemBackground))

            VStack {
                HStack {
                    Text("Total")
                        .font(.title)
                    Spacer()
                    Text(viewModel.calculateTotal().formatted(.currency(code: "TWD")))
                        .font(.title2)
                }
                .padding()

                Button {
                    viewModel.checkout()
                } label: {
                    Text("Checkout")
                        .fontWeight(.semibold)
                        .font(.title)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color("color/primary"))
                }
            }
            .alignmentGuide(.bottom) { $0[.bottom] - 100 }
        }
        .frame(maxWidth: 350)
    }
}

#Preview {
    CartView()
        .environmentObject(CheckoutViewModel())
}
