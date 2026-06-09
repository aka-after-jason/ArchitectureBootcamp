//
//  MVVMDIView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/1.
//

import SwiftUI

// MARK: MVVM with Protocols

// MARK: VIPER (View, Interactor, Presenter(vm), Entity, Router)

struct MVVMDIView: View {
    @State var presenter: MVVMDIPresenter
    var body: some View {
        ScrollView {
            VStack {
                ForEach(presenter.products) { product in
                    Text(product.title)
                        .onTapGesture {
                            presenter.onProductPressed(product: product)
                        }
                }
            }
            .task {
                do {
                    try await presenter.getProducts()
                } catch {
                    print("error with loading products: \(error)")
                }
            }
        }
        .navigationTitle("Product")
    }
}

#Preview {
    let container = DependencyContainer()
    container.regiser(UserManager.self, manager: UserManager())
    container.regiser(DataManager.self, manager: DataManager(service: MockDataService()))
    
    return RouterView { router in
        MVVMDIView(
            presenter: MVVMDIPresenter(
                interactor: CoreInteractor(container: container),
                router: CoreRouter(router: router)
            )
        )
    }
}
