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

    @Binding var selection: MenuItem?
    @State var appearance: MenuAppearance = .default

    var body: some View {
        if authService.status == .login {
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
                        TransactionsView(isNavagationBarOpened: $isOpened)
                    case .orders(let orderId):
                        OrderView(orderId: orderId, isNavagationBarOpened: $isOpened)
                    case .reports:
                        UnderConstructionView(isNavagationBarOpened: $isOpened)
                    case .items:
                        ItemsManageView(isNavagationBarOpened: $isOpened)
                    case .customers:
                        UnderConstructionView(isNavagationBarOpened: $isOpened)
                    case .settings:
                        SettingsView(isNavagationBarOpened: $isOpened)
                            .environmentObject(authService)
                    case .logout:
                        UnderConstructionView(isNavagationBarOpened: $isOpened)
                    case nil:
                        UnderConstructionView(isNavagationBarOpened: $isOpened)
                    }
                }
            )
        } else if authService.status == .logout {
            WelcomeView()
                .environmentObject(authService)
        } else if authService.status == .notDetermined {
            Text("Loading...")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(selection: .constant(.checkout))
    }
}
