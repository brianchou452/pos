//
//  FlexibleView.swift
//  pos
//
//  Created by Brian Chou on 2024/2/14.
//

import SwiftUI

/// Facade of our view, its main responsibility is to get the available width
/// and pass it down to the real implementation, `_FlexibleView`.
struct FlexibleView<Data: Collection, Content: View>: View where Data.Element: Hashable {
    let data: Data
    let spacing: CGFloat
    let alignment: HorizontalAlignment
    let content: (Data.Element) -> Content
    @State private var availableWidth: CGFloat = 0
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: alignment, vertical: .center)) {
            GeometryReader { geo in
                Color.clear
                    .onAppear {
                        availableWidth = geo.frame(in: .global).width
                    }
                    .onChange(of: geo.size) { _ in
                        availableWidth = geo.frame(in: .global).width
                    }
            }
            
            _FlexibleView(
                availableWidth: availableWidth,
                data: data,
                spacing: spacing,
                alignment: alignment,
                content: content
            )
        }
    }
}
