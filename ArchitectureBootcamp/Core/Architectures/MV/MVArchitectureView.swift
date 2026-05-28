//
//  MVArchitectureView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

// MV Architecture

/**
 2. MV Architecture (Vanilla SwiftUI)
    - DataManager is shared across the application
    - DataManager is responsible for business logic and data logic
    - DataManager holds the array of products
 
 Pros:
    - Less code
    - Easy to reuse business logic
 
 Cons:
    - Tightly coupled the business logic to the data logic
    - "Too easy" to reuse data (other View's can affect each other)
    - DataManager is simi-testable

 */

@MainActor
@Observable
class MVDataManager {
    // 注入 service
    private let service: MockDataService
    init(service: MockDataService) {
        self.service = service
    }
    
    // DataManager holds the array of products
    var products: [Product] = []
    
    func getProducts() async throws {
        products = try await service.getProducts()
    }
}

struct MVArchitectureView: View {
    @Environment(MVDataManager.self) private var mvDataManager
    var body: some View {
        VStack {
            ForEach(mvDataManager.products) { product in
                Text(product.title)
            }
        }
        .task {
            do {
                try await mvDataManager.getProducts()
            } catch {
                print("error loading products: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MVArchitectureView()
        .environment(MVDataManager(service: MockDataService())) // 这里需要注入MVDataManager
}
