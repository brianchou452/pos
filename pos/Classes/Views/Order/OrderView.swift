//
//  OrderView.swift
//  pos
//
//  Created by Brian Chou on 2024/11/24.
//

import SwiftUI

struct OrderView: View {
    let orderId: String?
    @StateObject var viewModel = OrderViewModel()
    @Binding var isNavagationBarOpened: Bool

    var body: some View {
        HStack {
            NavigationSplitView {
                OrderListView(orderId: orderId)
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
                    .navigationTitle("訂單")
                    .navigationSplitViewColumnWidth(min: 400, ideal: 500, max: 700)
            } detail: {
                if orderId != nil && DBService.shared.newOrder != nil {
                    OrderDetailView(order: DBService.shared.newOrder!)
                } else {
                    Text("請選擇訂單")
                }
            }
        }
    }
}
