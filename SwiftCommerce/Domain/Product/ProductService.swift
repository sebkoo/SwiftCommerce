//
//  ProductService.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/30/25.
//

import Foundation

protocol ProductService {
    func fetchProducts() async throws -> [Product]
}
