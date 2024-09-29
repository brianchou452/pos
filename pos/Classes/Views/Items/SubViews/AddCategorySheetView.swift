//
//  AddCategorySheetView.swift
//  pos
//
//  Created by Brian Chou on 2024/9/19.
//

import SwiftUI

struct AddCategorySheetView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var viewModel: ItemsManageViewModel

    @State private var name: String = ""
    

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    LabeledContent {
                        TextField("", text: $name)
                            .multilineTextAlignment(.trailing)
                    } label: {
                        Text("類別名稱")
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
                        let category = Category(name: name)
                        viewModel.addCategory(category: category)
                        dismiss()
                    }
                })
            })
        }
    }
}

#Preview {
    AddCategorySheetView()
}
