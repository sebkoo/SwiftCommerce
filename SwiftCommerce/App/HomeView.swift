//
//  HomeView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 6/1/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var cart = CartManager()

    var body: some View {
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

            NavigationStack {
                OrderHistoryView()
            }
            .tabItem {
                Label("History", systemImage: "clock.arrow.circlepath")
            }
        }
        .environmentObject(cart)    // Make CartManager globally accessible
    }
}

#Preview {
    HomeView()
}
