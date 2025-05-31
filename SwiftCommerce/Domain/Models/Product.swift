//
//  Product.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/30/25.
//

import Foundation

struct Product: Identifiable, Equatable, Codable, Hashable {
    let id: UUID
    let name: String
    let price: Double
    let imageURL: URL
}
