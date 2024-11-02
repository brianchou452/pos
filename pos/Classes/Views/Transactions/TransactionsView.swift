//
//  TransactionsView.swift
//  pos
//
//  Created by Brian Chou on 2023/11/30.
//

import SwiftUI

struct TransactionsView: View {
    @StateObject var viewModel = TransactionsViewModel()
    @Binding var isNavagationBarOpened: Bool

    var body: some View {
        NavigationSplitView {
            if #available(iOS 17.0, *) {
                TransactionsListView()
                    .environmentObject(viewModel)
                    .toolbar(removing: .sidebarToggle)
                    .toolbar(content: {
                        ToolbarItem(placement: .topBarLeading, content: {
                            Button {
                                isNavagationBarOpened.toggle()
                            } label: {
                                Image(systemName: "sidebar.left")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 20)
                                    .padding(5)
                            }
                        })
                    })
                    .navigationTitle("交易紀錄")
                    .navigationSplitViewColumnWidth(min: 400, ideal: 500, max: 700)
            } else {
                // TODO: 還沒使用 ios 16 裝置測試
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
                TransactionsListView()
                    .navigationSplitViewColumnWidth(min: 400, ideal: 500, max: 700)
                    .environmentObject(viewModel)
                    .toolbar(.hidden, for: .navigationBar)
            }
        } detail: {
            Text("Detail")
        }
    }
}

#Preview {
    TransactionsView(isNavagationBarOpened: .constant(false))
}
