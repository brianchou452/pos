//
//  AddItemSheetView.swift
//  pos
//
//  Created by Brian Chou on 2024/9/19.
//

import SwiftUI

struct AddItemSheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ItemsManageViewModel

    @State private var name: String = ""
    @State private var category: Category?
    @State private var price: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent {
                        TextField("", text: $name)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("商品名稱")
                    }
                    Picker("商品類別", selection: $category) {
                        Text("請選擇類別").tag(Category?(nil))
                        ForEach(viewModel.categories) { category in
                            Text(category.name).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                    .multilineTextAlignment(.trailing)
                    LabeledContent {
                        TextField("", text: $price)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.numberPad)
                    } label: {
                        Text("商品價格")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(content: {
                ToolbarItem(placement: .topBarLeading, content: {
                    Button("取消") {
                        dismiss()
                    }
                })
                ToolbarItem(placement: .topBarTrailing, content: {
                    Button("儲存") {
                        let price = Double(price) ?? 0
                        let item = Item(name: name, price: price, imageUrl: "", categoryID: category?.id ?? "")
                        viewModel.addItem(item: item)
                        dismiss()
                    }
                })
            })
        }
    }
}

#Preview {
    AddItemSheetView()
        .environmentObject(ItemsManageViewModel())
}
