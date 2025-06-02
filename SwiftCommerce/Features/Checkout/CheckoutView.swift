//
//  CheckoutView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

struct CheckoutView: View {
    @StateObject var viewModel: CheckoutViewModel

    var body: some View {
        Form {
            Section(header: Text("Credit Card")) {
                TextField("Credit Card Number", text: $viewModel.cardInfo.number)
                    .keyboardType(.numberPad)
                TextField("Expiry Date (MM/YY)", text: $viewModel.cardInfo.expiry)
                TextField("Credit Card CVV", text: $viewModel.cardInfo.cvv)
                    .keyboardType(.numberPad)
            }

            Section {
                if viewModel.isProcessing {
                    ProgressView("Processing Payment...")
                } else {
                    Button("Pay Now") {
                        Task { await viewModel.submitPayment() }
                    }
                }
            }

            if let error = viewModel.errorMessage {
                Section {
                    Text(error)
                        .foregroundColor(.red)
                }
            }

            if viewModel.showSuccess {
                Section {
                    Text("✅ Payment Successful!")
                        .foregroundColor(.green)
                }
            }
        }
        .navigationTitle("Payment")
    }
}

#Preview() {
    let mockProducts = [
        Product(
            id: 1,
            name: "Mock iPhone",
            price: 999.99,
            imageURL: URL(string: "https://example.com/iphone.jpg")!
        ),
        Product(
            id: 2,
            name: "Mock Watch",
            price: 199.99,
            imageURL: URL(string: "https://example.com/watch.jpg")!
        )
    ]

    let mockViewModel = CheckoutViewModel(products: mockProducts)

    return NavigationStack {
        CheckoutView(viewModel: mockViewModel)
    }
}
