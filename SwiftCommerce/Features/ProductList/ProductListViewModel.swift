//
//  ProductListViewModel.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

@MainActor
final class ProductListViewModel: ObservableObject {
    @Published var products: [Product] = []
    @Published var searchText: String = ""

    private let service: ProductServiceAPI

    init(service: ProductServiceAPI) {
        self.service = service
    }

    func fetchProducts() async {
        do {
            products = try await service.fetchProducts()
        } catch {
            print("Failed to fetch: \(error)")
        }
    }

    var filteredProducts: [Product] {
        guard !searchText.isEmpty else { return products }
        return products.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
    }
}

extension ProductListViewModel {
    static var previews: ProductListViewModel {
        let viewModel = ProductListViewModel(service: ProductServiceAPI())
        Task {
            await viewModel.fetchProducts()
        }
        return viewModel
    }
}
