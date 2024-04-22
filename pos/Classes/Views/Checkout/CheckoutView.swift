//
//  CheckoutView.swift
//  pos
//
//  Created by Brian Chou on 2023/11/30.
//

import SwiftUI

struct CheckoutView: View {
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    @Binding var isOpened: Bool
    @State private var isBottomSheetPresented = false
    @State private var showSheet = false
    
    @StateObject var viewModel = CheckoutViewModel()

    var body: some View {
        if horizontalSizeClass == .compact && verticalSizeClass == .regular { // iPhone 垂直的大小
            VStack {
                ItemsView()
                    .environmentObject(viewModel)
                
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
        } else {
            HStack {
                ItemsView()
                    .environmentObject(viewModel)
                CartView()
            }
        }
    }
}

#Preview {
    CheckoutView(isOpened: .constant(true))
}
