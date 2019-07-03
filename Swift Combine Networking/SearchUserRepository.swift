//
//  SearchUserRepository.swift
//  Swift Combine Networking
//
//  Created by Thibault Klein on 7/2/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

struct SearchUserResponse: Decodable {
    var items: [User]
}

struct User: Hashable, Identifiable, Decodable {
    var id: Int64
    var login: String
}

final class SearchUserRepository: BindableObject {
    var didChange = PassthroughSubject<SearchUserRepository, Never>()
    var subscriber: AnyCancellable?

    private(set) var users = [User]() {
        didSet {
            didChange.send(self)
        }
    }

    func search(name: String) {
        var urlComponents = URLComponents(string: "https://api.github.com/search/users")!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: name)
        ]

        let url = urlComponents.url!

        subscriber = HTTPClient.performRequest(url: url, decodingType: SearchUserResponse.self)
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.users, on: self)
    }
}

