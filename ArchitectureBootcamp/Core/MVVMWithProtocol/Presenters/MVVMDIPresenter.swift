//
//  MVVMDIViewModel.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//

import SwiftUI

@MainActor
@Observable
final class MVVMDIPresenter {
    let router: MVVMDIViewModelRouter
    let interactor: MVVMDIViewModelInteractor

    // 在 viewModel 里面注入 router
    init(interactor: MVVMDIViewModelInteractor, router: MVVMDIViewModelRouter) {
        self.interactor = interactor
        self.router = router
    }

    /// viewmodel holds the products
    var products: [Product] = []

    func getProducts() async throws {
        do {
            products = try await interactor.getProducts()
            _ = try await interactor.getUser()
        } catch {}
    }
    
    func onProductPressed(product: Product) {
        router.gotoProductView(product: product)
    }
}
