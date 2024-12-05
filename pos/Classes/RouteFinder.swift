//
//  RouteFinder.swift
//  pos
//
//  Created by Brian Chou on 2024/11/24.
//

import Foundation

enum DeepLinkURLs: String {
    case order
}

struct RouteFinder {
    func find(from url: URL) -> MenuItem? {
        guard let host = url.host() else { return nil }

        switch DeepLinkURLs(rawValue: host) {
        case .order:

            let queryParams = url.queryParameters

            guard let orderId = queryParams?["orderId"] as? String
            else { return .orders(orderId: nil) }

            return .orders(orderId: orderId)

        default:
            return nil
        }
    }
}

public extension URL {
    var queryParameters: [String: String]? {
        guard
            let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { result, item in
            result[item.name] = item.value?.replacingOccurrences(of: "+", with: " ")
        }
    }
}
