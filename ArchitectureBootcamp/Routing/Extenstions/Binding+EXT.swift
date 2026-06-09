//
//  Binding+EXT.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//

import SwiftUI

extension Binding where Value == Bool {
    init<T>(ifNotNil value: Binding<T?>) {
        self.init(
            get: {
                value.wrappedValue != nil
            },
            set: { newValue in
                if !newValue {
                    value.wrappedValue = nil
                }
            }
        )
    }
}
