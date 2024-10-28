//
//  ItemsView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/1.
//

import SwiftUI

struct ItemsView: View {
    @State var selectedIndex = 0
    @EnvironmentObject var viewModel: CheckoutViewModel
    @Binding var isNavagationBarOpened: Bool

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedIndex) {
                ForEach(viewModel.categorise.indices, id: \.self) { index in
                    ScrollView(.vertical) {
                        Spacer(minLength: 80)
                        FlexibleView(
                            data: viewModel.items.filter { item in
                                item.categoryID == viewModel.categorise[index].id
                            },
                            spacing: viewModel.spacing,
                            alignment: viewModel.alignment
                        ) { item in
                            ProductItemView(image: Image("checkout/food"), text: item.name)
                                .onTapGesture(perform: {
                                    print("tapped \(item.name)")
                                    viewModel.addItemToCart(item: CartItem(item: item))
                                })
                        }
                        .padding(.horizontal, viewModel.padding)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            TabBarView(tabbarItems: viewModel.categorise, isNavagationBarOpened: $isNavagationBarOpened, selectedIndex: $selectedIndex)
                .padding(.horizontal)
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView(isNavagationBarOpened: .constant(false))
            .environmentObject(CheckoutViewModel())
    }
}
