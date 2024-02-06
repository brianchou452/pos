//
//  TabBarView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/4.
//

import SwiftUI

struct TabBarView: View {
    var tabbarItems: [String]
    
    @Binding var selectedIndex: Int
    @Namespace private var menuItemTransition
    
    var body: some View {
        ScrollViewReader { scrollView in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(tabbarItems.indices, id: \.self) { index in
                        
                        TabBarItemView(name: tabbarItems[index], isActive: selectedIndex == index, namespace: menuItemTransition)
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

#Preview {
    TabBarView(tabbarItems: ["套餐", "主食", "副餐", "飲料", "甜點"], selectedIndex: .constant(0))
}
