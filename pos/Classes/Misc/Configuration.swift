//
//  Configuration.swift
//  pos
//
//  Created by Brian Chou on 2024/11/23.
//

import Foundation

enum AppConfiguration {
    enum Error: Swift.Error {
        case missingKey, invalidValue
    }
    
    static func value<T>(for key: String) throws -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            throw Error.missingKey
        }
        
        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            throw Error.invalidValue
        }
    }
}

enum S3Configuration {
    static var endpoint: String {
        return try! "https://" + AppConfiguration.value(for: "S3_STORAGE_ENDPOINT")
    }
    static var accessKey: String {
        return try! AppConfiguration.value(for: "S3_STORAGE_ACCESS_KEY")
    }
    static var secretKey: String {
        return try! AppConfiguration.value(for: "S3_STORAGE_SECRET_KEY")
    }
}

