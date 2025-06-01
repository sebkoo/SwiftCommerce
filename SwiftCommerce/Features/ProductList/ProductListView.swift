//
//  ProductListView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

struct ProductListView: View {
    @ObservedObject var viewModel: ProductListViewModel
    @EnvironmentObject var cart: CartManager    // shared instance

    var body: some View {
        List(viewModel.products) { product in
            NavigationLink {
                ProductDetailView(
                    viewModel: ProductDetailViewModel(product: product, cart: cart)
                )
            } label: {
                HStack {
                    ProductThumbnailView(url: product.imageURL)
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        Text(FormattedPrice.shared.string(from: product.price))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
            }
        }
        .task {
            await viewModel.fetchProducts()
        }
        .navigationTitle("Products")
    }
}

#Preview {
    NavigationStack {
        ProductListView(
            viewModel: {
                let mockService = MockProductService()
                let viewModel = ProductListViewModel(service: mockService)
                viewModel.products = [
                    Product(
                        id: UUID(),
                        name: "MacBook Air M3",
                        price: 1299,
                        imageURL: URL(string: "https://example.com/mackbook.jpg")!
                    )
                ]
                return viewModel
            }()
        )
        .environmentObject({
            let mockCart = CartManager()
            mockCart.add(Product(
                id: UUID(),
                name: "AirPods Max",
                price: 549,
                imageURL: URL(string: "https://example.com/airpods.jpg")!
            ))
            return mockCart
        }())
    }
}
