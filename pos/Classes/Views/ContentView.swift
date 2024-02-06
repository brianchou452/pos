//
//  ContentView.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import SwiftUI

struct ContentView: View {
    @State var isOpened = true

    @Environment(\.colorScheme) private var colorScheme

    @State private var selection: MenuItem? = .checkout
    @State var appearance: MenuAppearance = .default

    var body: some View {
        Drawer(
            isOpened: $isOpened,
            menu: {
                MenuView(selection: $selection)
                    .environment(\.colorScheme, colorScheme.inverted())
            },
            content: {
                switch selection {
                case .checkout:
                    CheckoutView(isOpened: $isOpened)
                case .transactions:
                    TransactionsView()
                case .orders:
                    CheckoutView(isOpened: $isOpened)
                case .reports:
                    CheckoutView(isOpened: $isOpened)
                case .items:
                    CheckoutView(isOpened: $isOpened)
                case .customers:
                    CheckoutView(isOpened: $isOpened)
                case .settings:
                    CheckoutView(isOpened: $isOpened)
                case .logout:
                    CheckoutView(isOpened: $isOpened)
                case nil:
                    CheckoutView(isOpened: $isOpened)
                }
            }
        )
        .statusBarHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
