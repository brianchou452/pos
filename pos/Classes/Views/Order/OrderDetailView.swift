//
//  OrderDetailView.swift
//  pos
//
//  Created by Brian Chou on 2024/12/5.
//

import SwiftUI

struct OrderDetailView: View {
    let order: Order

    var body: some View {
        VStack(alignment: .leading) {
            Text(order.createdAt.formatted(date: .numeric, time: .shortened))
                .font(.title)
                .foregroundColor(Color("color/primary"))
            Text("訂購人: \(order.user.name)")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))
            Text("訂購人 Email: \(order.user.email)")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))
            Text("訂購人電話: \(order.user.phone ?? "")")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))
            Text("ID: \(order.id ?? "")")
                .font(.subheadline)
                .foregroundColor(Color("color/text"))

            ScrollView {
                VStack {
                    ForEach(order.items, id: \.imageKey) { item in // TODO: Use id instead of imageKey
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
                Text(order.total.formatted(.currency(code: "TWD")))
                    .font(.title)
                    .foregroundColor(Color("color/primary"))
            }
        }
        .padding()
    }
}
