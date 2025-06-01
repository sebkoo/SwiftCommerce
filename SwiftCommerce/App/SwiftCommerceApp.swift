//
//  SwiftCommerceApp.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/30/25.
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
