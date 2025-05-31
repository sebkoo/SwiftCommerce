//
//  ProductListViewModel.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/30/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []

    private let service: ProductService

    init(service: ProductService) {
        self.service = service
    }

    func fetchProducts() async {
        do {
            products = try await service.fetchProducts()
        } catch {
            print("Failed to fetch: \(error)")
        }
    }
}
