//
//  ProductDetailViewModel.swift
//  SwiftCommerce
//
//  Created by Ben Koo on 5/30/25.
//

import Foundation

final class ProductDetailViewModel: ObservableObject {
    let product: Product

    init(product: Product) {
        self.product = product
    }
}
