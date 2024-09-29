//
//  TabBarView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/4.
//

import SwiftUI

struct TabBarView: View {
    var tabbarItems: [Category]

    @Binding var isNavagationBarOpened: Bool
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition

    var body: some View {
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
            ScrollViewReader { scrollView in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(tabbarItems.indices, id: \.self) { index in
                            TabBarItemView(name: tabbarItems[index].name, isActive: selectedIndex == index, namespace: menuItemTransition)
                                .onTapGesture {
                                    withAnimation(.easeInOut) {
                                        selectedIndex = index
                                    }
                                }
                        }
                    }
                }
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(25)
                .onChange(of: selectedIndex) { index in
                    withAnimation {
                        scrollView.scrollTo(index, anchor: .center)
                    }
                }
            }
        }
    }
}

#Preview {
    TabBarView(tabbarItems: [.init(name: "套餐"), .init(name: "主食"), .init(name: "副餐"), .init(name: "飲料"), .init(name: "甜點")], isNavagationBarOpened: .constant(false), selectedIndex: .constant(0))
}
