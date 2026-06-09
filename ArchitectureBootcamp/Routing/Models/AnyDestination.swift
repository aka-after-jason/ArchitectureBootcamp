//
//  AnyDestination.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

/// 这种方式更加灵活, 推荐使用
struct AnyDestination: Hashable {
    let id = UUID().uuidString
    var destination: AnyView
    
    /// destination 表示 view
    init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}
