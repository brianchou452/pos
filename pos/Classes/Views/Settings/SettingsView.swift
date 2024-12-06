//
//  SettingsView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var authService: AuthService
    @Binding var isNavagationBarOpened: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    isNavagationBarOpened.toggle()
                } label: {
                    Image(systemName: "sidebar.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .padding(5)
                }
                Spacer()
            }
            .padding()

            Spacer()

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

            Spacer()
        }
    }
}

#Preview {
    SettingsView(isNavagationBarOpened: .constant(true))
}
