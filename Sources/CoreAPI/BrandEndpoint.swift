//
//  BrandEndpoint.swift
//
//
//  Created by Abdelrahman Mohamed on 09/09/2024.
//

import Foundation
import NetworkLayer

public enum BrandEndpoint {
    case getBrandDetails(brandId: String, page: Int, perPage: Int, cursor: String?)
    case getProductDetails(brandId: String)
}
 
extension BrandEndpoint: Endpoint {
    
    // Base URL for the API
    public var baseURL: String {
        return "https://api.salla.dev"
    }
    
    // Path for each case
    public var path: String {
        switch self {
        case .getBrandDetails(let brandId, let page, let perPage, let cursor):
            var components = URLComponents(string: "/store/v1/brands/\(brandId)")!
            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "page", value: "\(page)"),
                URLQueryItem(name: "per_page", value: "\(perPage)")
            ]
            
            if let cursor = cursor {
                queryItems.append(URLQueryItem(name: "cursor", value: cursor))
            }
            
            components.queryItems = queryItems
            
            print("components.url!.absoluteString", components.url!.absoluteString)
            return components.url!.absoluteString
        case .getProductDetails(brandId: let brandId):
            return "/store/v1/brands/\(brandId)/details"
        }
    }
    
    // HTTP method for each case
    public var method: HTTPMethod {
        switch self {
        case .getBrandDetails, .getProductDetails:
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
