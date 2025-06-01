//
//  OrderHistoryView.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/31/25.
//

import SwiftUI

struct OrderHistoryView: View {
    @State private var history: [[Product]] = []

    var body: some View {
        NavigationStack {
            List {
                ForEach(history.indices, id: \.self) { index in
                    Section("Order #\(index + 1)") {
                        ForEach(history[index]) { item in
                            HStack {
                                ProductThumbnailView(url: item.imageURL)
                                Text(item.name)
                                Spacer()
                                Text(FormattedPrice.shared.string(from: item.price))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Order History")
            .onAppear {
                history = OrderHistoryService.shared.loadHistory()
            }
        }
    }
}

#Preview {
    // Set mock history in UserDefaults for preview
    @MainActor in
    let mockProducts = [
        Product(id: UUID(), name: "Mock Hat", price: 10.0, imageURL: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!),
        Product(id: UUID(), name: "Mock Shirt", price: 20.0, imageURL: URL(string: "https://fakestoreapi.com/img/71li-ujtlUL._AC_UX679_.jpg")!)
    ]

    OrderHistoryService.shared.clearHistory()
    OrderHistoryService.shared.save(order: mockProducts)

    return OrderHistoryView()
}

/*

 Unit Tests for CartView (ViewModel or UI layer with ViewInspector)

 💵 Promo Code or Discount Calculation

 🧪 Unit/UI Testing for CartView

 🛠 Fake Order Submission to Network Service

 🧪 Snapshot or UI test of OrderSummaryView

 🛠 Fake server request for order submission

 🧹 Add a TabView “Orders” history (for realism)

 🔄 Simulate order submission to server (with async/await delay)

 🧪 Snapshot/UI tests for OrderSummaryView

 🖼 Add AsyncImage for product thumbnails

 📜 Order History Tab

 🧹 Accessibility improvements (VoiceOver labels)

 ✅ Add App Icon + Launch Screen

 ✅ Display mock order ID in OrderSummaryView

 🧢 Add ProductDetailView image & polish

 📲 Add App Icon + Launch Screen

 🧠 Add Accessibility & VoiceOver Labels
 */
