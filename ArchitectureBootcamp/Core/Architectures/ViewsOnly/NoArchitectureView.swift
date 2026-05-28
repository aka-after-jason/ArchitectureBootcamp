//
//  NoArchitectureView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

// NO Architecture (Views only)

/**
 1. No Architecture (Vanilla SwiftUI)
    - There is no DataManager, Views are responsible for business logic & data logic
    - View holds the array of products
 
 Pros:
    - Simplest code
    - Easy to set up, low chance for bugs
 
 Cons:
    - No speration, between View and Data layers
    - Not testable, mockable or reusable
 */

struct NoArchitectureView: View {
    // View holds the products
    @State private var products: [Product] = []
    var body: some View {
        VStack {
            ForEach(products) { product in
                Text(product.title)
            }
        }
        .task {
            do {
                products = try await loadProducts()
            } catch {
                print("error loading products: \(error.localizedDescription)")
            }
        }
    }
    
    // Views are responsible for business logic & data logic
    private func loadProducts() async throws -> [Product] {
        guard let url = URL(string: Const.products_url) else {
            throw URLError(.badURL)
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        let products = try JSONDecoder().decode(ProductArray.self, from: data)
        return products.products
    }
}

#Preview {
    NoArchitectureView()
}
