//
//  OrderHistoryView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct OrderHistoryView: View {
    @State private var history: [[Product]] = []
    @State private var searchText: String = ""

    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredHistory.indices, id: \.self) { index in
                    let order = filteredHistory[index]
                    if !order.isEmpty {
                        Section("Order #\(index + 1)") {
                            ForEach(order) { item in
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
            }
            .navigationTitle("Order History")
            .searchable(text: $searchText, prompt: "Search by product name")
            .onAppear {
                history = OrderHistoryService.shared.loadHistory()
            }
        }
    }

    private var filteredHistory: [[Product]] {
        if searchText.isEmpty {
            return history
        }

        return history.map { order in
            order.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }.filter { !$0.isEmpty }
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
