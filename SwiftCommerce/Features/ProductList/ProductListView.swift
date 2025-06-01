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
        List(viewModel.filteredProducts) { product in
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
                }
            }
        }
        .navigationTitle("Home")
        .searchable(text: $viewModel.searchText, prompt: "Search products")
        .task {
            await viewModel.fetchProducts()
        }
    }
}

#Preview {
    NavigationStack {
        ProductListView(viewModel: ProductListViewModel(service: ProductServiceAPI()))
    }
    .tabItem {
        Label("Home", systemImage: "house")
    }
}
