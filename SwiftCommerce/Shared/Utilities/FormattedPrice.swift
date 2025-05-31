//
//  PriceFormatter.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import Foundation

struct FormattedPrice {
    static let shared = FormattedPrice()

    private let formatter: NumberFormatter

    private init() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        formatter.maximumFractionDigits = 2
        self.formatter = formatter
    }

    func string(from value: Double) -> String {
        formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
}
