//
//  CoreInteractor.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//
import SwiftUI

/**
 protocol composition
 CoreInteractor 包括所有需要的方法
 */
@MainActor
struct CoreInteractor {
    
    private let dataManager: DataManager
    private let userManager: UserManager
    init(container: DependencyContainer) {
        self.dataManager = container.resolve(DataManager.self)!
        self.userManager = container.resolve(UserManager.self)!
    }
    
    func getProducts() async throws -> [Product] {
        try await dataManager.getProducts()
    }
    
    func getUser() async throws -> String {
        try await userManager.getUser()
    }
    
    func getMovies() async throws -> [String] {
        try await dataManager.getMovies()
    }
}
