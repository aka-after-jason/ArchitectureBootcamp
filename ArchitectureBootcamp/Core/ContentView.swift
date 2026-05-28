//
//  ContentView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

// ARCHITECTURE
// Vanilla SwiftUI
// NO ARCHITECTURE(Views only) -> MV ARCHITECTURE(MV) -> MVC ARCHITECTURE(MVC)

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


// 4. MVVM Architecture
/**
 - DataManager is shared accross the application, but access from the ViewModel
 - ViewModels are responsible for business logic
 - ViewModel holds the array of products
 
 Pros:
 - Seperated the View from the business logic
 - Business logic is now testable
 - View code is much cleaner
 
 Cons:
 - More difficult to set up and inject dependencies
 - ViewModel lifecycle is outside of View lifecycle (cannot use SwiftUI Property Wrappers)
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
