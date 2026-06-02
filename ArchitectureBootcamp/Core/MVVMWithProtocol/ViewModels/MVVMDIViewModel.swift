//
//  MVVMDIViewModel.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//

import SwiftUI

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
