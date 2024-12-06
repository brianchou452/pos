//
//  UnderConstructionView.swift
//  pos
//
//  Created by Brian Chou on 2024/12/6.
//

import SwiftUI

struct UnderConstructionView: View {
    @Binding var isNavagationBarOpened: Bool

    var body: some View {
        VStack {
            HStack {
                Button {
                    isNavagationBarOpened.toggle()
                } label: {
                    Image(systemName: "sidebar.left")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .padding(5)
                }
                Spacer()
            }
            .padding()

            Spacer()

            Text("Under Construction")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.secondary)
                .padding()

            Spacer()
        }
    }
}
