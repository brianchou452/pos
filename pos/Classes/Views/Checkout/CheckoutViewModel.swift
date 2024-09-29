//
//  CheckoutViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import Foundation
import SwiftUI

class CheckoutViewModel: ObservableObject {
    @Published var spacing: CGFloat = 8
    @Published var padding: CGFloat = 8
    @Published var wordCount: Int = 75
    @Published var alignmentIndex = 0
    
    let alignments: [HorizontalAlignment] = [.leading, .center, .trailing]
    
    var alignment: HorizontalAlignment {
        alignments[alignmentIndex]
    }
    
    private let db = DBService.shared
    @Published var items: [Item] = []
    @Published var categorise: [Category] = []
    
    init() {
        Task {
            await getItems()
            await getCategorise()
        }
    }
    
    private func getCategorise() async {
        do {
            try db.getCategoriseQuery()
                .addSnapshotListener { [weak self] querySnapshot, error in
                    guard let documents = querySnapshot?.documents,
                          let self = self
                    else {
                        print("Error fetching documents")
                        return
                    }
                    do {
                        self.categorise = try documents.compactMap { try $0.data(as: Category.self) }
                    } catch {
                        print(error.localizedDescription)
                        // TODO: error handle
                    }
                }
        } catch {
            print(error)
        }
    }
    
    private func getItems() async {
        do {
            try db.getItemsQuery()
                .addSnapshotListener { [weak self] querySnapshot, error in
                    guard let documents = querySnapshot?.documents,
                          let self = self
                    else {
                        print("Error fetching documents")
                        return
                    }
                    do {
                        self.items = try documents.compactMap { try $0.data(as: Item.self) }
                    } catch {
                        print(error.localizedDescription)
                        // TODO: error handle
                    }
                }
        } catch {
            print(error)
        }
    }
}
