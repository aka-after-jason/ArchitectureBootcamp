//
//  HomeViewModel.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//
import SwiftUI


@MainActor
@Observable
final class HomeViewModel {
    let interactor: HomeViewModelInteractor
    init(interactor: HomeViewModelInteractor) {
        self.interactor = interactor
    }
 
    var movies: [String] = []
    
    func getMovies() async throws {
        movies = try await interactor.getMovies()
    }
}
