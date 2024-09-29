//
//  ItemsManageViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/4/29.
//

import Foundation

class ItemsManageViewModel: ObservableObject {
    private let db = DBService.shared
    @Published var items: [Item] = []
    @Published var categorise: [Category] = []

    init() {
        Task {
            await getItems()
            await getCategorise()
        }
    }

    func addItem(item: Item) {
        Task {
            do {
                _ = try db.add(item: item)
            } catch {
                print(error)
            }
        }
    }

    func addCategory(category: Category) {
        Task {
            do {
                _ = try db.add(category: category)
            } catch {
                print(error)
            }
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
