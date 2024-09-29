//
//  ItemsView.swift
//  pos
//
//  Created by Brian Chou on 2024/4/23.
//

import SwiftUI

struct ItemsManageView: View {
    @Binding var isNavagationBarOpened: Bool
    @StateObject var viewModel = ItemsManageViewModel()

    var body: some View {
        NavigationSplitView {
            if #available(iOS 17.0, *) {
                itemsSettingsList()
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
                    .navigationTitle("商品管理")
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
                itemsSettingsList()
                    .toolbar(.hidden, for: .navigationBar)
            }
        } detail: {
            Text("請先從左側選擇一項設定")
        }
        .navigationSplitViewStyle(.balanced)
    }

    @ViewBuilder
    private func itemsSettingsList() -> some View {
        List {
            ForEach(ItemsSettings.allCases) { item in
                switch item {
                case .items:
                    NavigationLink(destination: ItemManageListView().environmentObject(viewModel)) {
                        Text("\(item.rawValue)")
                    }
                case .category:
                    NavigationLink(destination: CategoryManageListView().environmentObject(viewModel)) {
                        Text("\(item.rawValue)")
                    }
                case .sets:
                    NavigationLink(destination: Text("Details of \(item.rawValue)")) {
                        Text("\(item.rawValue)")
                    }
                case .modifiers:
                    NavigationLink(destination: Text("Details of \(item.rawValue)")) {
                        Text("\(item.rawValue)")
                    }
                case .discounts:
                    NavigationLink(destination: Text("Details of \(item.rawValue)")) {
                        Text("\(item.rawValue)")
                    }
                }
            }
        }
    }
}

#Preview {
    ItemsManageView(isNavagationBarOpened: .constant(false))
}
