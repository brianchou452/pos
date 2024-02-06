//
//  ItemsView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/1.
//

import SwiftUI

struct ItemsView: View {
    @State var selectedIndex = 0
    
    let colors: [Color] = [.yellow, .blue, .green, .indigo, .brown]
    let tabbarItems = ["套餐", "主食", "副餐", "飲料", "甜點"]
    
    var body: some View {
        ZStack(alignment: .top) {
            TabView(selection: $selectedIndex) {
                ForEach(colors.indices, id: \.self) { index in
                    colors[index]
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .tag(index)
                        .ignoresSafeArea()
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            .ignoresSafeArea()
            
            TabBarView(tabbarItems: tabbarItems, selectedIndex: $selectedIndex)
                .padding(.horizontal)
        }
    }
}

struct ItemsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        
        TabBarView(tabbarItems: ["套餐", "主食", "副餐", "飲料", "甜點"], selectedIndex: .constant(0)).previewDisplayName("TabBarView")
    }
}
