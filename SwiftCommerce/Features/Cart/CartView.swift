//
//  CartView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var cart: CartManager

    var body: some View {
        List {
            ForEach(cart.items) { product in
                HStack {
                    Text(product.name)
                    Spacer()
                    Text("$\(product.price, specifier: "%.2f")")
                        .foregroundColor(.secondary)
                }
            }

            if cart.items.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
        .navigationTitle("Cart")
    }
}

#Preview {
    let cart = CartManager()
    cart.addToCart(Product(
        id: UUID(),
        name: "Preview Hat",
        price: 29.99,
        imageURL: URL(string: "https://example.com/hat.jpg")!
    ))

    return NavigationStack {
        CartView(cart: cart)
    }
}
