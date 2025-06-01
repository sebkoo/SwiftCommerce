//
//  CartItemRow.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct CartItemRow: View {
    let product: Product
    let onRemove: () -> Void

    var body: some View {
        HStack {
            ProductThumbnailView(url: product.imageURL)
            VStack(alignment: .leading) {
                Text(product.name)
                Text(FormattedPrice.shared.string(from: product.price))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
            Button(role: .destructive, action: onRemove) {
                Image(systemName: "trash")
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CartItemRow(
        product: Product(
            id: UUID(),
            name: "Sample Backpack",
            price: 59.99,
            imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!
        ),
        onRemove: { print("🗑️ Removed item in preview") }
    )
    .padding()
}
