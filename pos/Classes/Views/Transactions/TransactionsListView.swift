//
//  TransactionsListView.swift
//  pos
//
//  Created by Brian Chou on 2024/10/29.
//

import SwiftUI

struct TransactionsListView: View {
    @EnvironmentObject var viewModel: TransactionsViewModel

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.transactions) { item in
                    NavigationLink(destination: {
                        TransactionDetailView(transaction: item)
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
                                    viewModel.getTransactionList()
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

    func listItem(item: Transaction) -> some View {
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
