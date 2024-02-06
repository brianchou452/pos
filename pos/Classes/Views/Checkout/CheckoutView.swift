//
//  CheckoutView.swift
//  pos
//
//  Created by Brian Chou on 2023/11/30.
//

import SwiftUI

struct CheckoutView: View {
    @Binding var isOpened: Bool
    @State private var isBottomSheetPresented = false
    @State private var showSheet = false

    @State private var orientation = UIDevice.current.orientation
    let tabbarItems = ["套餐", "主食", "副餐", "飲料", "甜點"]

    var body: some View {
        VStack {
            if orientation.isLandscape {
                HStack {
                    ItemsView()
                    CartView()
                }
            } else {
                VStack {
                    ItemsView()

                    Button("Show Bottom Sheet") {
                        showSheet.toggle()
                    }
                    .tint(.black)
                    .buttonStyle(.borderedProminent)
                    .sheet(isPresented: $showSheet) {
                        CartView()
                            .presentationDetents([.medium, .large])
                    }
                }
            }
        }.detectOrientation($orientation)
    }
}

#Preview {
    CheckoutView(isOpened: .constant(true))
}
