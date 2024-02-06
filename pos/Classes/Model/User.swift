//
//  User.swift
//  pos
//
//  Created by Brian Chou on 2023/11/24.
//

import Foundation
import SwiftUI

struct User {
    let name: String
    let position: String
    let imageName: String
}

extension User {
    static let stub = User(name: "Brian Chou", position: "老闆", imageName: "person.circle")
}
