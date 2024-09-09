//
//  BrandResponse.swift
//  
//
//  Created by Abdelrahman Mohamed on 10/09/2024.
//

import Foundation

public struct BrandResponse: Decodable {
    public let status: Int
    public let success: Bool
    public let data: [Brand]
}

public struct BrandDetailsResponse: Decodable {
    public let status: Int
    public let success: Bool
    public let data: Brand
}

public struct Brand: Decodable {
    public let id: String
    public let name: String
    public let price: Double
    public let image: BrandImage
    public let brand: BrandInfo?
}

public struct BrandImage: Decodable {
    public let url: String
}

public struct BrandInfo: Decodable {
    public let id: String?
    public let name: String?
}
