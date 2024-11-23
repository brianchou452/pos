//
//  ItemsManageViewModel.swift
//  pos
//
//  Created by Brian Chou on 2024/4/29.
//

import Foundation
import PhotosUI
import SwiftUI

class ItemsManageViewModel: ObservableObject {
    private let db = DBService.shared
    private var s3: S3Service?
    @Published var items: [Item] = []
    @Published var categories: [Category] = []

    enum ImageState {
        case empty
        case loading(Progress)
        case success(UIImage)
        case failure(Error)
    }

    init() {
//        UserDefaults.storeID = "krg4SLjvfXgVv5hdQYWz"
        Task {
            try? self.s3 = await S3Service()
            await getItems()
            await getCategories()
        }
    }

    enum TransferError: Error {
        case importFailed
    }

    struct ProductImage: Transferable {
        let image: UIImage

        static var transferRepresentation: some TransferRepresentation {
            DataRepresentation(importedContentType: .image) { data in
                guard let uiImage = UIImage(data: data) else {
                    throw TransferError.importFailed
                }
                return ProductImage(image: uiImage)
            }
        }
    }

    @Published private(set) var productImageState: ImageState = .empty

    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            if let imageSelection {
                let progress = loadTransferable(from: imageSelection)
                productImageState = .loading(progress)
            } else {
                productImageState = .empty
            }
        }
    }

    private func loadTransferable(from imageSelection: PhotosPickerItem) -> Progress {
        return imageSelection.loadTransferable(type: ProductImage.self) { result in
            DispatchQueue.main.async {
                guard imageSelection == self.imageSelection else {
                    print("Failed to get the selected item.")
                    return
                }
                switch result {
                case .success(let productImage?):
                    self.productImageState = .success(productImage.image)
                case .success(nil):
                    self.productImageState = .empty
                case .failure(let error):
                    self.productImageState = .failure(error)
                }
            }
        }
    }

    func addItem(item: Item) {
        var itemWithImage = item
        Task {
            do {
                switch productImageState {
                case .success(let image):
                    let uuid = UUID().uuidString
                    guard let storeID = UserDefaults.storeID else { throw DBServiceError.storeIdNotFound }
                    let imageKey = "menus/\(storeID)/\(uuid).jpeg"
                    try await s3?.createFile(bucket: "pos", key: imageKey, withData: image.jpegData(compressionQuality: 0.8) ?? Data())
                    itemWithImage.imageKey = imageKey
                    itemWithImage.imageUrl = "https://storage-api.seaotter.cc/pos/\(imageKey)"
                default:
                    break
                }

                _ = try db.add(item: itemWithImage)
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

    private func getCategories() async {
        do {
            try db.getCategoriesQuery()
                .addSnapshotListener { [weak self] querySnapshot, error in
                    guard let documents = querySnapshot?.documents,
                          let self = self
                    else {
                        print("Error fetching documents")
                        return
                    }
                    do {
                        self.categories = try documents.compactMap { try $0.data(as: Category.self) }
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
