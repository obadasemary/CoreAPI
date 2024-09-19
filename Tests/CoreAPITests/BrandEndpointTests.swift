import XCTest
@testable import CoreAPI
import NetworkLayer

final class BrandEndpointTests: XCTestCase {
    
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
    
    // Mock response helper
    func mockBrandResponse() -> Data {
        return """
            {
                "status": 200,
                "success": true,
                "data": [
                    {
                        "id": "599203108",
                        "name": "Brand 1",
                        "price": 115,
                        "image": { "url": "https://example.com/image.png" },
                        "brand": { "id": "99911771", "name": "Armani" }
                    }
                ]
            }
            """.data(using: .utf8)!
    }
    
    func mockEmptyBrandResponse() -> Data {
        return """
        {
            "status": 200,
            "success": true,
            "data": []
        }
        """.data(using: .utf8)!
    }
    
    func testBrandEndpoint_GivenValidResponse_ReturnsBrands() async throws {
        let expectedData = mockBrandResponse()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedData)
        }
        
        let endpoint = BrandEndpoint.getBrandDetails(brandId: "1724782240", page: 1, perPage: 5, cursor: "")
        let response: BrandResponse = try await sut.request(
            endpoint: endpoint,
            responseModel: BrandResponse.self
        )
        
        XCTAssertEqual(response.data.first?.name, "Brand 1")
    }
    
    func testBrandEndpoint_GivenEmptyResponse_ReturnsNoBrands() async throws {
        let expectedData = mockEmptyBrandResponse()
        
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, expectedData)
        }
        
        let endpoint = BrandEndpoint.getBrandDetails(brandId: "1724782240", page: 1, perPage: 5, cursor: "")
        let response: BrandResponse = try await sut.request(
            endpoint: endpoint,
            responseModel: BrandResponse.self
        )
        
        XCTAssertTrue(response.data.isEmpty)
    }
}
