//
//  OrderService.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import Foundation

struct OrderPayload: Codable {
    let userId: Int
    let date: String
    let products: [ProductPayload]
}

struct ProductPayload: Codable {
    let productId: Int
    let quantity: Int
}

struct OrderResponse: Codable {
    let id: Int
    let userId: Int
    let date: String
    let products: [ProductPayload]
}

final class OrderService {
    static let shared = OrderService()

    func submitOrder(products: [Product]) async throws -> OrderResponse {
        let url = URL(string: "https://fakestoreapi.com/carts")!
        let date = ISO8601DateFormatter().string(from: Date())

        let payload = OrderPayload(
            userId: 1,
            date: date,
            products: products.map {
                ProductPayload(productId: $0.hashValue % 100, quantity: 1)  // Simulate productId
            }
        )

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(payload)

        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(OrderResponse.self, from: data)
    }
}
