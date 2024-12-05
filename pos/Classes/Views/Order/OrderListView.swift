//
//  OrderListView.swift
//  pos
//
//  Created by Brian Chou on 2024/11/24.
//
import SwiftUI

struct OrderListView: View {
    @EnvironmentObject var viewModel: OrderViewModel
    let orderId: String?

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.orders) { item in
                    NavigationLink(destination: {
                        OrderDetailView(order: item)
                    }, label: {
                        listItem(item: item)
                    })
                }
                if !viewModel.isEndOfList {
                    Group {
                        switch viewModel.listLoadingState {
                        case .loading:
                            ProgressView()
                                .controlSize(.large)
                        case .success:
                            ProgressView()
                                .controlSize(.large)
                                .onAppear {
                                    viewModel.getOrderList()
                                }
                        case .fail(let error):
                            Text(error)
                        }
                    }
                    .frame(minHeight: 100)
                }
            }
        }
    }

    func listItem(item: Order) -> some View {
        VStack(alignment: .leading) {
            Text(item.createdAt.formatted(date: .numeric, time: .shortened))
                .font(.subheadline)
                .foregroundColor(Color("color/primary"))
            Spacer()
            HStack {
                Spacer()
                Text(item.total.formatted(.currency(code: "TWD")))
                    .font(.title)
                    .foregroundColor(Color("color/primary"))
            }
            Divider()
        }
        .padding()
    }
}
