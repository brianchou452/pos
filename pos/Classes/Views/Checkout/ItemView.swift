//
//  ItemView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/15.
//

import SwiftUI

struct ItemView: View {
    var image: Image
    var text: String
    var body: some View {
        ZStack {
            Image("checkout/food")
                .resizable()
                .scaledToFit()
            VStack(alignment: .leading) {
                Spacer()
                Text(text)
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
    ItemView(image: Image("checkout/food"), text: "Food")
}
