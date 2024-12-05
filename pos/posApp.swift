//
//  posApp.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import FirebaseAuth
import FirebaseCore
import GoogleSignIn
import SwiftUI


@main
struct posApp: App {
    // register app delegate for Firebase setup
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var authService = AuthService.shared
    @State var menuSelection: MenuItem? = .checkout

    var body: some Scene {
        WindowGroup {
            ContentView(selection: $menuSelection)
                .environmentObject(authService)
                .onOpenURL { url in
                    handleDeeplink(from: url)
                }
        }
    }
}

extension posApp {
    func handleDeeplink(from url: URL) {
        let routeFinder = RouteFinder()
        if let route = routeFinder.find(from: url) {
            menuSelection = route
        }
    }
}
