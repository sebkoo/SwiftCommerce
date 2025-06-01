//
//  SwiftCommerceApp.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

@main
struct SwiftCommerceApp: App {
    @StateObject var cart = CartManager()

    var body: some Scene {
        WindowGroup {
            TabView {
                NavigationStack {
                    ProductListView(
                        viewModel: ProductListViewModel(
                            service: RealProductService()
                        )
                    )
                }
                .tabItem {
                    Label("Shop", systemImage: "bag")
                }

                NavigationStack {
                    CartView()
                }
                .tabItem {
                    Label("Cart", systemImage: "cart")
                }
                .badge(cart.totalItems)

                OrderHistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock.arrow.circlepath")
                    }
            }
            .environmentObject(cart)    // Make CartManager globally accessible
        }
    }
}
