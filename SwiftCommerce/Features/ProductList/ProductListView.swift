//
//  ProductListView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel
    var cart: CartManager

    var body: some View {
        List(viewModel.products) { product in
            NavigationLink {
                ProductDetailView(
                    viewModel: ProductDetailViewModel(product: product, cart: cart)
                )
            } label: {
                VStack(alignment: .leading) {
                    Text(product.name)
                        .font(.headline)
                    Text("$\(product.price, specifier: "%.2f")")
                        .font(.subheadline)
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
    let mockCart = CartManager()

    NavigationStack {
        ProductListView(viewModel: .previews, cart: mockCart)
    }
}
