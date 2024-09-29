//
//  UserDefaults+Key.swift
//  pos
//
//  Created by Brian Chou on 2024/9/16.
//

import Foundation

extension UserDefaults {
    static var storeID: String? {
        get { return UserDefaults.standard.string(forKey: "storeID") }
        set { UserDefaults.standard.set(newValue, forKey: "storeID") }
    }
}
