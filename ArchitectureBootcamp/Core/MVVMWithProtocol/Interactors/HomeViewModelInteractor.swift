//
//  HomeViewModelInteractor.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//

import SwiftUI

protocol HomeViewModelInteractor {
    func getMovies() async throws -> [String]
    func getUser() async throws -> String
}

extension CoreInteractor: HomeViewModelInteractor {}
