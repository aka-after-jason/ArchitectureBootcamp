//
//  ContentView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

/**
 ARCHITECTURE NOTES
 
 1. No Architecture (Vanilla SwiftUI)
    - There is no DataManager, Views are responsible for business logic & data logic
    - View holds the array of products
 
 Pros:
    - Simplest code
    - Easy to set up, low chance for bugs
 
 Cons:
    - No speration, between View and Data layers
    - Not testable, mockable or reusable
 
 2.
 
 
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

@Observable
@MainActor
class DataManager {
    
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
    
    func getProducts() async throws -> [Product] {
        try await service.getProducts()
    }
}

struct ContentView: View {
    
    @Environment(DataManager.self) private var dataManager
    @State private var products: [Product] = []
    var body: some View {
        VStack {
            ForEach(products) { product in
                Text(product.title)
            }
        }
        .padding()
        .task {
            await loadProducts()
        }
    }
    
    private func loadProducts() async {
        do {
            products =  try await dataManager.getProducts()
        } catch {
            print("Error loading products: \(error.localizedDescription)")
        }
    }
}

#Preview {
    ContentView()
        .environment(DataManager(service: MockDataService())) // 放在 environment 里面
}
