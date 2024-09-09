//
//  BrandEndpoint.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation
import NetworkLayer

public enum BrandEndpoint {
    case getBrands(brandId: String, page: Int, perPage: Int)
    case getBrandDetails(brandId: String)
}
 
extension BrandEndpoint: Endpoint {
    
    // Base URL for the API
    public var baseURL: String {
        return "https://api.salla.dev"
    }
    
    // Path for each case
    public var path: String {
        switch self {
        case .getBrands(let brandId, let page, let perPage):
            var components = URLComponents(string: "/store/v1/brands/\(brandId)")!
            components.queryItems = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            return components.url!.absoluteString
        case .getBrandDetails(brandId: let brandId):
            return "/store/v1/brands/\(brandId)/details"
        }
    }
    
    // HTTP method for each case
    public var method: HTTPMethod {
        switch self {
        case .getBrands, .getBrandDetails:
            return .get
        }
    }
    
    // Headers for each case
    public var headers: HTTPHeaders {
        return [
            "Currency": "SAR",
            "AppVersion": "3.0.0",
            "Store-Identifier": "1328842359"
        ]
    }
    
    // Parameters are nil for GET requests
    public var parameters: [String: Any]? {
        return nil
    }
    
    // Content type for requests
    public var contentType: String {
        return "application/json"
    }
}
