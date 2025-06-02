//
//  CheckoutViewModel.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import Foundation

@MainActor
final class CheckoutViewModel: ObservableObject {
    @Published var cardInfo = CreditCardInfo(number: "", expiry: "", cvv: "")
    @Published var isProcessing = false
    @Published var showSuccess = false
    @Published var errorMessage: String?

    let products: [Product]

    init(products: [Product]) {
        self.products = products
    }

    func submitPayment() async {
        guard validateCardInfo() else {
            errorMessage = "Invalid card details"
            return
        }

        isProcessing = true
        errorMessage = nil

        do {
            try await Task.sleep(nanoseconds: 1_000_000_000)    // Simulate 1s processing
            _ = try await OrderService.shared.submitOrder(products: products)
            showSuccess = true
        } catch {
            errorMessage = "Payment failed: \(error.localizedDescription)"
        }

        isProcessing = false
    }

    private func validateCardInfo() -> Bool {
        cardInfo.number.count == 16 &&
        cardInfo.expiry.count >= 4 &&
        cardInfo.cvv.count == 3
    }
}
