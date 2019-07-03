//
//  URLSession+Combine.swift
//  Swift Combine Networking
//
//  Created by Thibault Klein on 7/3/19.
//  Copyright © 2019 Thibault Klein. All rights reserved.
//

import Foundation
import Combine

enum RequestError: Error {
    case request(code: Int, message: String)
}

extension URLSession {
    func perform(request: URLRequest) -> AnyPublisher<Data, RequestError> {
        URLSession.shared
            .dataTaskPublisher(for: request)
            .map { $0.data }
            .mapError { error in
                RequestError.request(code: error.errorCode, message: error.localizedDescription)
            }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
