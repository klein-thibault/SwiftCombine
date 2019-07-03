//
//  HTTPClient.swift
//  Swift Combine Networking
//
//  Created by Thibault Klein on 7/3/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import Combine

final class HTTPClient {
    static func performRequest<Model>(url: URL,
                               decodingType: Model.Type) -> AnyPublisher<Model, Error> where Model: Decodable {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        return URLSession.shared
            .perform(request: request)
            .decode(type: decodingType, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
