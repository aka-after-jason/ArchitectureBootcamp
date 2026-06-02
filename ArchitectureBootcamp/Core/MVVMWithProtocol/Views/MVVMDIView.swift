//
//  MVVMDIView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/1.
//

import SwiftUI

// MARK: MVVM with Protocols

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

#Preview {
    let container = DependencyContainer()
    container.regiser(UserManager.self, manager: UserManager())
    container.regiser(DataManager.self, manager: DataManager(service: MockDataService()))
    
    return MVVMDIView(viewModel: MVVMDIViewModel(interactor: CoreInteractor(container: container)))
}
