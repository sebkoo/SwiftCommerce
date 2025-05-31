//
//  OrderSummaryView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct OrderSummaryView: View {
    let items: [Product]
    let totalPrice: Double

    var body: some View {
        VStack(spacing: 20) {
            Text("🎉 Thank you for your purchase!")
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)

            List(items) { item in
                HStack {
                    Text(item.name)
                    Spacer()
                    Text(FormattedPrice.shared.string(from: item.price))
                        .foregroundColor(.secondary)
                }
            }

            HStack {
                Text("Total:")
                    .fontWeight(.bold)
                Spacer()
                Text(FormattedPrice.shared.string(from: totalPrice))
                    .font(.title3)
                    .fontWeight(.bold)
            }
            .padding()

            Spacer()
        }
        .navigationTitle("Order Summary")
    }
}

#Preview {
    let sampleItems: [Product] = [
        Product(id: UUID(), name: "Bag", price: 45.0, imageURL: URL(string: "https://bag.com")!),
        Product(id: UUID(), name: "Cap", price: 25.0, imageURL: URL(string: "https://cap.com")!)
    ]
    return NavigationStack {
        OrderSummaryView(items: sampleItems, totalPrice: 70.0)
    }
}
