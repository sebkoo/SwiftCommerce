//
//  ProductDetailView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

struct ProductDetailView: View {
    @ObservedObject var viewModel: ProductDetailViewModel

    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                AsyncImage(url: viewModel.product.imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(height: 300)
                .cornerRadius(16)

                Text(viewModel.product.name)
                    .font(.title)
                    .fontWeight(.bold)

                Text(String(format: "$%.2f", viewModel.product.price))
                    .font(.title2)
                    .foregroundColor(.secondary)

                Button("Add to Cart") {
                    viewModel.addToCart()
                }
                .buttonStyle(.borderedProminent)
                .padding(.top, 20)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockProduct = Product(
        id: UUID(),
        name: "Preview Shoes",
        price: 79.99,
        imageURL: URL(string: "https://example.com/preview.jpg")!
    )

    let mockCart = CartManager()
    let viewModel = ProductDetailViewModel(product: mockProduct, cart: mockCart)

    return NavigationStack {
        ProductDetailView(viewModel: viewModel)
    }
}
