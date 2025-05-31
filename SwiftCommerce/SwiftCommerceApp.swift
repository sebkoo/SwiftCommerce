//
//  SwiftCommerceApp.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import SwiftUI

@main
struct SwiftCommerceApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ProductListView(viewModel: ProductListViewModel(service: RealProductService()))
            }
        }
    }
}
