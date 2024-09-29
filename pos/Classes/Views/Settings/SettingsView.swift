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
        VStack {
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

            Button {
                let store = Store(name: "真好吃")
                let db = DBService.shared
                do {
                    let docID = try db.add(store: store)
                    UserDefaults.storeID = docID
                    print("add store: doc ID \(docID)")
                } catch {
                    print(error.localizedDescription)
                }
            }
            label: {
                Text("新增商家")
            }
        }
    }
}

#Preview {
    SettingsView(isOpened: .constant(true))
}
