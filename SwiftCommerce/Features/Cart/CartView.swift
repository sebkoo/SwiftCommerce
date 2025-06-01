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
            productList

            if !cart.items.isEmpty {
                cartSummary
            }
        }
        .navigationTitle("Cart")
        .alert("Confirm Purchase", isPresented: $showConfirm) {
            Button("Confirm", role: .destructive) {
                Task { await submitOrder() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to place this order?")
        }
        .navigationDestination(isPresented: $showSummary) {
            OrderSummaryView(
                items: lastPurchased,
                totalPrice: lastPurchased.reduce(0) { $0 + $1.price }
            )
        }
        .overlay {submissionOverlay}
        .alert("Submission Error", isPresented: .constant(submissionError != nil)) {
            Button("OK", role: .cancel) { submissionError = nil }
        } message: {
            Text(submissionError ?? "Unknown error")
        }
    }
}

// MARK: - Subviews

private extension CartView {
    var productList: some View {
        List {
            ForEach(cart.items) { product in
                CartItemRow(product: product) {
                    cart.remove(product)
                }
            }
            .onDelete { cart.remove(atOffsets: $0) }

            if cart.items.isEmpty {
                Text("Your cart is empty.")
                    .foregroundColor(.gray)
                    .padding()
            }
        }
    }

    var cartSummary: some View {
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

    var submissionOverlay: some View {
        Group {
            if isSubmitting {
                ProgressView("Submitting Order...")
                    .padding()
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
    }
}

// MARK: - Order Submission Logic

private extension CartView {
    func submitOrder() async {
        isSubmitting = true
        submissionError = nil
        defer { isSubmitting = false }

        do {
            let response = try await OrderService.shared.submitOrder(products: cart.items)
            print("✅ Order submitted: \(response.id)")
            lastPurchased = cart.items
            cart.clear()
            showSummary = true
        } catch {
            submissionError = error.localizedDescription
        }
    }
}

#Preview {
    NavigationStack {
        CartView()
            .environmentObject({
                let mockCart = CartManager()
                mockCart.clear()
                mockCart.add(Product(
                    id: UUID(),
                    name: "Preview Hat",
                    price: 29.99,
                    imageURL: URL(string: "https://example.com/hat.jpg")!
                ))
                return mockCart
            }())
    }
}
