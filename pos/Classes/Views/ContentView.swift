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
    @EnvironmentObject var authService: AuthService

    @State private var selection: MenuItem? = .checkout
    @State var appearance: MenuAppearance = .default

    var body: some View {
        if authService.isSignedIn {
            Drawer(
                isOpened: $isOpened,
                menu: {
                    MenuView(selection: $selection)
                        .environment(\.colorScheme, colorScheme.inverted())
                },
                content: {
                    switch selection {
                    case .checkout:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    case .transactions:
                        TransactionsView()
                    case .orders:
                        LoginView()
                    case .reports:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    case .items:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    case .customers:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    case .settings:
                        SettingsView(isOpened: $isOpened)
                            .environmentObject(authService)
                    case .logout:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    case nil:
                        CheckoutView(isNavagationBarOpened: $isOpened)
                    }
                }
            )
        } else {
            WelcomeView()
                .environmentObject(authService)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
