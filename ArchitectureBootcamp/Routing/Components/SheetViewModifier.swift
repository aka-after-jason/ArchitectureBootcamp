//
//  SheetViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

extension View {
    // sheet
    func sheetViewModifier(screen: Binding<AnyDestination?>) -> some View {
        self
            .sheet(isPresented: Binding(ifNotNil: screen)) {
                ZStack {
                    if let screen = screen.wrappedValue {
                        screen.destination
                    }
                }
            }
    }
    
    // fullScreenCover
    func fullScreenCoverViewModifier(screen: Binding<AnyDestination?>) -> some View {
        self
            .fullScreenCover(isPresented: Binding(ifNotNil: screen)) {
                ZStack {
                    if let screen = screen.wrappedValue {
                        screen.destination
                    }
                }
            }
    }
}
