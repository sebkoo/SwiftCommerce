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
            VStack(spacing: 20) {
                AsyncImage(url: viewModel.product.imageURL) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(height: 300)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .cornerRadius(16)
                            .accessibilityLabel(viewModel.product.name)
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                            .foregroundColor(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }

                VStack(alignment: .leading, spacing: 12) {
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
                    .accessibilityLabel("Add \(viewModel.product.name) to cart")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            }
            .padding(.top)
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    let mockProduct = Product(
        id: 1,
        name: "Running Shoes",
        price: 79.99,
        imageURL: URL(string: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg")!
    )

    let mockCart = CartManager()
    let viewModel = ProductDetailViewModel(product: mockProduct, cart: mockCart)

    return NavigationStack {
        ProductDetailView(viewModel: viewModel)
    }
}
