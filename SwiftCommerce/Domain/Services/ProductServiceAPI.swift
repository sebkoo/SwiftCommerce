//
//  ProductServiceAPI.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

struct ProductServiceAPI: ProductService {
    func fetchProducts() async throws -> [Product] {
        let url = URL(string: "https://fakestoreapi.com/products")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Product].self, from: data)
    }
}
