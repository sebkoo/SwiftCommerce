//
//  ProductDetailViewModel.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    let product: Product

    init(product: Product) {
        self.product = product
    }
}
