//
//  MVVMDIView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/1.
//

import SwiftUI

// MARK: MVVM with Protocols

@MainActor
struct ProductMVVMDIViewModelInteractor: MVVMDIViewModelInteractor {
    // 将 viewModel 中的 依赖抽取到这里
    private let userManager: UserManager
    private let dataManager: DataManager
    init(container: DependencyContainer) {
        self.userManager = container.resolve(UserManager.self)!
        self.dataManager = container.resolve(DataManager.self)!
    }

    func getProducts() async throws -> [Product] {
        try await dataManager.getProducts()
    }

    func getUser() async throws -> String {
        try await userManager.getUser()
    }
}

@MainActor
struct MockMVVMDIViewModelInteractor: MVVMDIViewModelInteractor {
    func getProducts() async throws -> [Product] {
        [Product(id: 1, title: "This is my product")]
    }

    func getUser() async throws -> String {
        UUID().uuidString
    }
}


/// 这个协议中只存储需要用到的方法
protocol MVVMDIViewModelInteractor {
    func getProducts() async throws -> [Product]
    func getUser() async throws -> String
}

@MainActor
@Observable
final class MVVMDIViewModel {
    let interactor: MVVMDIViewModelInteractor

    init(interactor: MVVMDIViewModelInteractor) {
        self.interactor = interactor
    }

    /// viewmodel holds the products
    var products: [Product] = []

    func getProducts() async throws {
        do {
            products = try await interactor.getProducts()
            _ = try await interactor.getUser()
        } catch {}
    }
}

struct MVVMDIView: View {
    @State var viewModel: MVVMDIViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.products) { product in
                    Text(product.title)
                }
            }
            .task {
                do {
                    try await viewModel.getProducts()
                } catch {
                    print("error with loading products: \(error)")
                }
            }
        }
    }
}

#Preview("Product") {
    let container = DependencyContainer()
    container.regiser(UserManager.self, manager: UserManager())
    container.regiser(DataManager.self, manager: DataManager(service: MockDataService()))
    
    return MVVMDIView(viewModel: MVVMDIViewModel(interactor: ProductMVVMDIViewModelInteractor(container: container)))
}

#Preview("Mock") {
    MVVMDIView(viewModel: MVVMDIViewModel(interactor: MockMVVMDIViewModelInteractor()))
}
