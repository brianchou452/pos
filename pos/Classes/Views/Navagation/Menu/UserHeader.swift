//
//  UserHeader.swift
//  pos
//
//  Created by Brian Chou on 2023/11/27.
//

import SwiftUI

private extension CGFloat {
    static let hSpacing: Self = 24
    static let nameHeight: Self = 28
    static let positionHeight: Self = 20
    static let vSpacing: Self = 6
}

struct UserHeader: View {
    let user: User

    var body: some View {
        Label(
            title: {
                VStack(alignment: .leading, spacing: .vSpacing) {
                    Text(user.name)
                        .typographyStyle(.headline)

                    Text(user.position)
                        .typographyStyle(.subheadline)
                }
                .foregroundColor(Color("color/text"))
            },
            icon: {
                UserImage(imageName: user.imageName)
            }
        )
        .labelStyle(.menuLabel)
    }
}

struct UserProfileHeader_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            UserHeader(user: .stub)

            UserHeader(user: .stub)
                .menuAppearance(.compact)
        }
        .background(Color("color/background"))
        .previewLayout(.sizeThatFits)
    }
}
