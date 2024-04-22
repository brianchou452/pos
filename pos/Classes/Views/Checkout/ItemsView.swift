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

    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedIndex) {
                ForEach(viewModel.category.indices, id: \.self) { index in
                    ScrollView(.vertical) {
                        Spacer(minLength: 80)
                        FlexibleView(
                            data: viewModel.originalItems[index],
                            spacing: viewModel.spacing,
                            alignment: viewModel.alignment
                        ) { item in
                            ItemView(image: Image("checkout/food"), text: item)
                        }
                        .padding(.horizontal, viewModel.padding)
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            TabBarView(tabbarItems: viewModel.category, selectedIndex: $selectedIndex)
                .padding(.horizontal)
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ItemsView()
            .environmentObject(CheckoutViewModel())
    }
}
