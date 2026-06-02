//
//  HomeView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//

import SwiftUI

struct HomeView: View {
    @State var viewModel: HomeViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(viewModel.movies, id: \.self) { movie in
                    Text(movie)
                        .foregroundStyle(.green)
                }
            }
            .task {
                do {
                    try await viewModel.getMovies()
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
    
    return HomeView(viewModel: HomeViewModel(interactor: CoreInteractor(container: container)))
}
