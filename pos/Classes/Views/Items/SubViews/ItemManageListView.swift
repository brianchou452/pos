//
//  ItemManageListView.swift
//  pos
//
//  Created by Brian Chou on 2024/9/17.
//

import SwiftUI

struct ItemManageListView: View {
    @EnvironmentObject var viewModel: ItemsManageViewModel
    @State private var showingSheet = false

    var body: some View {
        if viewModel.categories.isEmpty {
            Text("請先新增一個類別")
        }
        List {
            ForEach(viewModel.categories) { category in
                Section(header: Text(category.name)) {
                    ForEach(viewModel.items.filter { item in
                        item.categoryID == category.id
                    }) { item in
                        Text(item.name)
                    }
                }
            }
        }
        .listStyle(.insetGrouped)
        .toolbar(content: {
            Button(action: {
                showingSheet.toggle()
            }, label: {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $showingSheet) {
                AddItemSheetView()
            }
        })
    }
}

#Preview {
    ItemManageListView()
}
