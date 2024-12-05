//
//  User.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import FirebaseFirestore
import Foundation

struct User: Codable {
    @DocumentID public var id: String?
    let userID: String
    let email: String
    let name: String
    let profileImageUrl: URL?
    let position: String
    let imageName: String
    let phone: String?

    init() {
        self.userID = "fakeUserID"
        self.email = "fake@seaotter.cc"
        self.name = "沒有使用者"
        self.profileImageUrl = nil
        self.position = "Boss"
        self.imageName = "person.circle"
        self.phone = nil
    }

    init(id: String? = nil, userID: String, email: String, name: String, profileImageUrl: URL?, position: String, imageName: String) {
        self.id = id
        self.userID = userID
        self.email = email
        self.name = name
        self.profileImageUrl = profileImageUrl
        self.position = position
        self.imageName = imageName
        self.phone = nil
    }
}

extension User {
    static let stub = User(userID: "uid", email: "fake@seaotter.cc", name: "BC", profileImageUrl: nil, position: "Boss", imageName: "person.circle")
}
