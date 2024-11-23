//
//  ProductImage.swift
//  pos
//
//  Created by Brian Chou on 2024/11/16.
//

import PhotosUI
import SwiftUI

struct ProductImage: View {
    let imageState: ItemsManageViewModel.ImageState

    var body: some View {
        switch imageState {
        case .success(let image):
            Image(uiImage: image).resizable()
        case .loading:
            ProgressView()
        case .empty:
            Image(systemName: "photo.artframe")
                .font(.system(size: 40))
                .foregroundColor(.white)
        case .failure:
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 40))
                .foregroundColor(.white)
        }
    }
}

struct RoundedProductImage: View {
    let imageState: ItemsManageViewModel.ImageState

    var body: some View {
        ProductImage(imageState: imageState)
            .scaledToFill()
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .frame(width: 100, height: 100)
            .background {
                RoundedRectangle(cornerRadius: 20).fill(
                    LinearGradient(
                        colors: [.yellow, .orange],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            }
    }
}

struct EditableRoundedProductImage: View {
    @ObservedObject var viewModel: ItemsManageViewModel

    var body: some View {
        RoundedProductImage(imageState: viewModel.productImageState)
            .overlay(alignment: .bottomTrailing) {
                PhotosPicker(selection: $viewModel.imageSelection,
                             matching: .images,
                             photoLibrary: .shared())
                {
                    Image(systemName: "pencil.circle.fill")
                        .symbolRenderingMode(.multicolor)
                        .font(.system(size: 30))
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.borderless)
            }
    }
}
