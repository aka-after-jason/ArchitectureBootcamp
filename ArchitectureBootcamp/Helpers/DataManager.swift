//
//  DataManager.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/1.
//

import SwiftUI

@Observable
@MainActor
class DataManager {
    
    private let service: DataService
    
    init(service: DataService) {
        self.service = service
    }
    
    func getProducts() async throws -> [Product] {
        try await service.getProducts()
    }
    
    // 假设我们有一个 getMovies 方法
    func getMovies() async throws -> [String] {
        ["MovieA"]
    }
}
