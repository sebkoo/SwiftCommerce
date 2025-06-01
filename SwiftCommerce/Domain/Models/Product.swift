//
//  Product.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

struct Product: Identifiable, Equatable, Codable, Hashable {
    let id: Int
    let name: String
    let price: Double
    let imageURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case name = "title"
        case price
        case imageURL = "image"
    }
}
