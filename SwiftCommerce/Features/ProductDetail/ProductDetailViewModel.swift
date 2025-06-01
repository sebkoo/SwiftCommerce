//
//  ProductDetailViewModel.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    let product: Product
    let cart: CartManager

    init(product: Product, cart: CartManager) {
        self.product = product
        self.cart = cart
    }

    func addToCart() {
        cart.add(product)
    }
}
