//
//  MVVMArchitectureView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

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


@MainActor
@Observable
class MVVMArchitectureViewModel {
    // 注入 dataManager
    private let dataManager: DataManager
    init(dataManager: DataManager) {
        self.dataManager = dataManager
    }
    
    // ViewModel holds the array of products
    var products: [Product] = []
    
    func loadData() async {
        do {
            products = try await dataManager.getProducts()
        } catch {
            print("error loading data: \(error.localizedDescription)")
        }
    }
}

struct MVVMArchitectureView: View {
    @State var vm: MVVMArchitectureViewModel
    var body: some View {
        VStack {
            ForEach(vm.products) { product in
                Text(product.title)
            }
        }
        .task {
            await vm.loadData()
        }
    }
}

#Preview {
    MVVMArchitectureView(vm: MVVMArchitectureViewModel(dataManager: DataManager(service: MockDataService())))
}
