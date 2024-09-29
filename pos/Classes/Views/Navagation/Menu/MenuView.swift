//
//  MenuBackground.swift
//  pos
//
//  Created by Brian Chou on 2023/11/27.
//

import SwiftUI

struct MenuView: View {
    @Binding private var selection: MenuItem?

    @SceneStorage("menuAppearance")
    private var appearance: MenuAppearance = .default

    @State private var colorScheme: ColorScheme?
    @Environment(\.colorScheme) private var systemColorScheme

    // MARK: - Init
    init(selection: Binding<MenuItem?>) {
        _selection = selection
    }

    // MARK: - Body
    var body: some View {
        VStack {
            MenuItemList(selection: $selection, user: AuthService.shared.user) {
                withAnimation {
                    appearance.toggle()
                }
            }

            // TODO: add version label

            Spacer()
        }
        .fixedSize(horizontal: true, vertical: false)
        .padding()
        .backgroundPreferenceValue(AnchorPreferenceKey<CGRect>.self) { anchor in
            MenuBackground(colorScheme: colorScheme ?? systemColorScheme)
                .transition(.menuBackgroundFadeIn(from: anchor))
                .id(colorScheme ?? systemColorScheme)
        }
        .menuAppearance(appearance)
        .animation(.default, value: colorScheme)
        .clipped()
        .background {
            RoundedRectangle(cornerRadius: UIDimenion.backgroundCornerRadius)
                .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 0)
        }
        .padding(.leading)
    }
}

struct MenuView_Previews: PreviewProvider {
    struct Preview: View {
        @State var appearance: MenuAppearance = .default
        @State var menuItem: MenuItem? = .checkout

        var body: some View {
            ZStack(alignment: .leading) {
                MenuView(selection: $menuItem)
                    .menuAppearance(appearance)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            appearance.toggle()
                        }
                    }
            }
        }
    }

    static var previews: some View {
        Preview()
            .previewLayout(.sizeThatFits)
    }
}
