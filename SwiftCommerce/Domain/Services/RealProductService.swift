//
//  RealProductService.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class RealProductService: ProductService {
    func fetchProducts() async throws -> [Product] {
        guard let url = Bundle.main.url(forResource: "products", withExtension: "json") else {
            throw URLError(.fileDoesNotExist)
        }

        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
