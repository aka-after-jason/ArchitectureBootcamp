//
//  MVCArchitectureView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

// MVC Architecture

/**
 3. MVC Architecture (Vanilla SwiftUI)
    - Three is a DataManager, Views are responsible for bunisess logic but not data logic.
    - View holds the array of products
 
 Pros:
    - DataManager is shared across the application
    - DataManager is testable, mockable or reusable
 
 Cons:
    - Business logic is not testable
    - Massive View Controller problem!

 */


@MainActor
@Observable
class MVCDataManager {
    // 注入service
    private let service: DataService
    init(service: DataService) {
        self.service = service
    }
    
    func getProducts() async throws -> [Product] {
        try await service.getProducts()
    }
}

struct MVCArchitectureView: View {
    
    // View holds the array of products
    @State private var products: [Product] = []
    
    @Environment(MVCDataManager.self) private var mvcDataManager
    
    var body: some View {
        VStack {
            ForEach(products) { product in
                Text(product.title)
            }
        }
        .task {
            do {
                products = try await mvcDataManager.getProducts()
            } catch {
                print("error loading products: \(error.localizedDescription)")
            }
        }
    }
}

#Preview {
    MVCArchitectureView()
        .environment(MVCDataManager(service: MockDataService())) // 需要注入 MVCDataManager
}
