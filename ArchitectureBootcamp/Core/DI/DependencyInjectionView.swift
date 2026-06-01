//
//  DependencyInjectionView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/5/28.
//

import SwiftUI

// Dependency Injection
// https://github.com/Swinject/Swinject

@MainActor
@Observable
class DependencyInjectionViewModel {
    
    private let dataManager: DataManager
    private let userManager: UserManager
    
    // 注入 DependencyContainer
    init(container: DependencyContainer) {
        self.dataManager = container.resolve(DataManager.self)!
        self.userManager = container.resolve(UserManager.self)!
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

struct DependencyInjectionView: View {
    @State var vm: DependencyInjectionViewModel
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
    let container = DependencyContainer()
    container.regiser(DataManager.self, manager: DataManager(service: MockDataService()))
    container.regiser(UserManager.self, manager: UserManager())
    container.register(UserManager.self) {
        UserManager()
    }
    
    return DependencyInjectionView(
        vm: DependencyInjectionViewModel(container: container)
    )
}
