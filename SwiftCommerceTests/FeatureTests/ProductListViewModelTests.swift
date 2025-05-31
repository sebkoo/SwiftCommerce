//
//  ProductListViewModelTests.swift
//  SwiftCommerceTests
//
//  Created by Bonmyeong Koo - Vendor on 5/30/25.
//

import XCTest
@testable import SwiftCommerce

final class ProductListViewModelTests: XCTestCase {
    
    @MainActor
    func testFetchProductsLoadsProducts() async throws {
        let viewModel = ProductListViewModel(service: MockProductService())
        await viewModel.fetchProducts()

        XCTAssertEqual(viewModel.products.count, 2)
        XCTAssertEqual(viewModel.products.first?.name, "Mock Shoes")
    }
}
