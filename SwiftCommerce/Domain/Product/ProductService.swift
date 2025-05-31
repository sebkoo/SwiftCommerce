//
//  ProductService.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

protocol ProductService {
    func fetchProducts() async throws -> [Product]
}
