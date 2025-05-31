//
//  ProductListView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

struct ProductListView: View {
    @StateObject var viewModel: ProductListViewModel

    var body: some View {
        List(viewModel.products) { product in
            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text("$\(product.price, specifier: "%.2f")")
                    .font(.subheadline)
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
        ProductListView(viewModel: .previews)
    }
}
