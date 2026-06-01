//
//  UserManager.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/1.
//

import SwiftUI

@MainActor
@Observable
class UserManager {
    func getUser() async throws -> String {
        UUID().uuidString
    }
}
