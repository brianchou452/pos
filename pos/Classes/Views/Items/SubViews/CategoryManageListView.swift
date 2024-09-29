//
//  CategoryManageListView.swift
//  pos
//
//  Created by Brian Chou on 2024/9/19.
//

import SwiftUI

struct CategoryManageListView: View {
    @EnvironmentObject var viewModel: ItemsManageViewModel
    @State private var showingSheet = false
    
    var body: some View {
        List {
            ForEach(viewModel.categorise) { category in
                Text(category.name)
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
                AddCategorySheetView()
                    .environmentObject(viewModel)
            }
        })
    }
}

#Preview {
    CategoryManageListView()
        .environmentObject(ItemsManageViewModel())
}
