import XCTest
@testable import CoreAPI
import NetworkLayer

final class BrandDetailsEndpointTests: XCTestCase {
    
    var sut: URLSessionNetworkService!
    
    override func setUp() {
        super.setUp()
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: configuration)
        sut = URLSessionNetworkService(session: session)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func mockProductDetailsResponse() -> Data {
        return """
        {
            "status": 200,
            "success": true,
            "data": {
                "id": "304266723",
                "name": "Product 1",
                "price": 115,
                "image": { "url": "https://example.com/image.png" }
            }
        }
        """.data(using: .utf8)!
    }
    
    func testProductDetailsEndpoint_GivenValidResponse_ReturnsProductDetails() async throws {
        let expectedData = mockProductDetailsResponse()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!
            return (response, expectedData)
        }
        
        let endpoint = BrandEndpoint.getBrandDetails(brandId: "304266723")
        let response: BrandDetailsResponse = try await sut.request(
            endpoint: endpoint,
            responseModel: BrandDetailsResponse.self
        )
        
        XCTAssertEqual(response.data.name, "Product 1")
    }
}
