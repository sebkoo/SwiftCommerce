//
//  ProductThumbnailView.swift
//  SwiftCommerce
//
//  Created by Bonmyeong Koo - Vendor on 5/31/25.
//

import SwiftUI

struct ProductThumbnailView: View {
    let url: URL

    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: 50, height: 50)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .cornerRadius(6)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(.gray)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ProductThumbnailView(url: URL(string: "https://fakestoreapi.com/img/81fPKd-2AYL._AC_SL1500_.jpg")!
    )
    .padding()
}
