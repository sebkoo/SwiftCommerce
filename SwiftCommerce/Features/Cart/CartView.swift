//
//  CartView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartManager    // shared instance

    var body: some View {
        VStack {
            List {
                ForEach(cart.items) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text("$\(product.price, specifier: "%.2f")")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete { indexSet in
                    cart.remove(atOffsets: indexSet)
                }

                if cart.items.isEmpty {
                    Text("Your cart is empty.")
                        .foregroundColor(.gray)
                        .padding()
                }
            }

            if !cart.items.isEmpty {
                HStack {
                    Text("Total:")
                        .fontWeight(.bold)
                    Spacer()
                    Text("$\(cart.totalPrice, specifier: "%.2f")")
                        .font(.title3)
                        .fontWeight(.bold)
                }
                .padding()
            }
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject({
                let mockCart = CartManager()
                mockCart.addToCart(Product(
                    id: UUID(),
                    name: "Preview Hat",
                    price: 29.99,
                    imageURL: URL(string: "https://example.com/hat.jpg")!
                ))
                return mockCart
            }())
    }
}
