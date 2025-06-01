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
            HomeView()
        }
    }
}
