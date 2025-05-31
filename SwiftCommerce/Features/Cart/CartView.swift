//
//  CartView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: CartManager    // shared instance
    @State private var showConfirm = false
    @State private var showSummary = false
    @State private var lastPurchased: [Product] = []
    @State private var isSubmitting = false
    @State private var submissionError: String?

    var body: some View {
        VStack {
            List {
                ForEach(cart.items) { product in
                    HStack {
                        Text(product.name)
                        Spacer()
                        Text(FormattedPrice.shared.string(from: product.price))
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
                VStack(spacing: 12) {
                    HStack {
                        Text("Total:")
                            .fontWeight(.bold)
                        Spacer()
                        Text(FormattedPrice.shared.string(from: cart.totalPrice))
                            .font(.title3)
                            .fontWeight(.bold)
                    }

                    Button("Checkout") {
                        showConfirm = true
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.large)
                    .frame(maxWidth: .infinity)
                    .padding(.top, 4)
                }
                .padding()
            }
        }
        .navigationTitle("Cart")
        .alert("Confirm Purchase", isPresented: $showConfirm) {
            Button("Confirm", role: .destructive) {
                Task { await submitOrder() }
            }
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure you want to place this order?")
        }
        .navigationDestination(isPresented: $showSummary) {
            OrderSummaryView(
                items: lastPurchased,
                totalPrice: lastPurchased.reduce(0) { $0 + $1.price }
            )
        }
        .overlay {
            if isSubmitting {
                ProgressView("Submitting Order...")
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .alert("Submission Error", isPresented: .constant(submissionError != nil)) {
            Button("OK", role: .cancel) { submissionError = nil }
        } message: {
            Text(submissionError ?? "Unknown")
        }
    }
}

extension CartView {
    private func submitOrder() async {
        isSubmitting = true
        submissionError = nil
        do {
            let response = try await OrderService.shared.submitOrder(products: cart.items)
            print("✅ Order submitted: \(response.id)")

            lastPurchased = cart.items
            cart.clearCart()
            showSummary = true
        } catch {
            submissionError = error.localizedDescription
        }
        isSubmitting = false
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
