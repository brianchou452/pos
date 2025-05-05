//
//  TransactionDetailView.swift
//  pos
//
//  Created by Brian Chou on 2024/10/29.
//

import SwiftUI

struct TransactionDetailView: View {
    let transaction: Transaction

    var body: some View {
        VStack(alignment: .leading) {
            Text(transaction.createdAt.formatted(date: .numeric, time: .shortened))
                .font(.title)
                .foregroundColor(Color("color/primary"))
            Text("User: \(transaction.user.name)")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))
            Text("ID: \(transaction.id ?? "")")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))

            ScrollView {
                VStack {
                    ForEach(transaction.items) { item in
                        TransactionItemView(item: item)
                    }
                }
                .padding()
            }

            Spacer()
            Divider()
            HStack {
                Text("Total")
                    .font(.title)
                    .foregroundColor(Color("color/primary"))
                Spacer()
                Text(transaction.total.formatted(.currency(code: "TWD")))
                    .font(.title)
                    .foregroundColor(Color("color/primary"))
            }
        }
        .padding()
    }
}
