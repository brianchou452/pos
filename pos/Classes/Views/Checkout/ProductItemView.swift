//
//  ProductItemView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/15.
//

import Kingfisher
import SwiftUI

struct ProductItemView: View {
    var imageUrl: String
    var text: String
    var body: some View {
        ZStack {
            if imageUrl.isEmpty {
                Image("checkout/food")
                    .resizable()
                    .scaledToFit()
            } else {
                KFImage.url(URL(string: imageUrl))
                    .placeholder {
                        ProgressView()
                    }
                    .fade(duration: 0.25)
                    .resizable()
                    .scaledToFill()
            }

            VStack(alignment: .leading) {
                Spacer()
                Text(text).background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 8, style: .circular))
            }
            .padding(5)
        }
        .frame(width: 130, height: 130)
        .clipShape(
            RoundedRectangle(cornerRadius: 8, style: .continuous)
        )
        .overlay(RoundedRectangle(cornerRadius: 8, style: .continuous)
            .stroke(.gray, lineWidth: 1)
        )
    }
}

#Preview {
    ProductItemView(imageUrl: "", text: "Food")
}
