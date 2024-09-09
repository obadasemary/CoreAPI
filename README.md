# CoreAPI

This repository contains the CoreAPI.

## Write Requests Fast!

CoreAPI's compact syntax and extensive feature set allow requests with powerful features like automatic retry to be written in just a few lines of code.

```swift
import CoreAPI
import NetworkLayer

let networkService = URLSessionNetworkService()

// Automatic String to URL conversion, Swift concurrency support, and automatic retry.
Task {
    do {
        let endpoint = BrandEndpoint.getBrands(brandId: "1724782240", page: 1, perPage: 5)
        let response: BrandResponse = try await networkService.request(endpoint: endpoint, responseModel: BrandResponse.self)
        print(response)
    } catch {
        print("Failed to fetch Brand: \(error)")
    }
}
```

# How to Use it?

-  Once you have your Swift package set up, adding `CoreAPI` as a dependency is as easy as adding it to the `dependencies` value of your `Package.swift` or the Package list in Xcode.

```swift
dependencies: [
    .package(url: "https://github.com/obadasemary/CoreAPI.git", .upToNextMajor(from: "1.0.1"))
]
```
