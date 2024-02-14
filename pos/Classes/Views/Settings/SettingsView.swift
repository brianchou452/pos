//
//  SettingsView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import SwiftUI

struct SettingsView: View {
    @Binding var isOpened: Bool
    @EnvironmentObject var authService: AuthService

    var body: some View {
        Button {
            authService.signOut(completion: { result in
                if result != nil {
                    print(result ?? "")
                } else {
                    print("成功登出")
                }
            })
        } label: {
            Text("登出")
        }
    }
}

#Preview {
    SettingsView(isOpened: .constant(true))
}
