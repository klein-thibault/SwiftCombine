# SwiftCombine

Project demonstrating how Swift Combine can be used for both UI using SwiftUI and networking using a URLSession publisher.

This project uses the Github API to query users by name and populate a list.

⚠️ The Github API has a [rate limit](https://developer.github.com/v3/search/#rate-limit) of 10 requests per minute.

## Requirements

* Xcode 11 beta
* Swift 5.1 beta
* iOS 13 beta

## SwiftUI

Demonstrating the use of `BindableObject` to feed a SwiftUI view with data using functional reactive programming. The `SearchUserRepository` conforms to the `BindableObject` and provides a publisher for the view to be recreated as soon as an event happens.

```swift
final class SearchUserRepository: BindableObject {
	var didChange = PassthroughSubject<SearchUserRepository, Never>()
	
	private(set) var users = [User]() {
        didSet {
            didChange.send(self)
        }
    }
}
```

## Swift Combine

Demonstrating the use of Publishers and Subscribers using the built-in `URLSession` publisher `dataTaskPublisher(for:)`.

### URLSession Publisher

```swift
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
```

### Subscriber

```
let subscriber = HTTPClient.performRequest(url: url, decodingType: SearchUserResponse.self)
            .map { $0.items }
            .replaceError(with: [])
            .assign(to: \.users, on: self)
```

# External Links

* Inspirational Github [repository](https://github.com/ra1028/SwiftUI-Combine)
* Apple Combine Developer [documentation](https://developer.apple.com/documentation/combine)