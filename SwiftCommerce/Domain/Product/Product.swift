//
//  Product.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

struct Product: Identifiable, Equatable {
    var id: UUID
    var name: String
    var price: Double
}
