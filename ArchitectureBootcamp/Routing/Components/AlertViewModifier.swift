//
//  AlertViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

extension View {
    @ViewBuilder
    func showCustomAlert(type: AlertType = .alert, alert: Binding<AnyAppAlert?>) -> some View {
        switch type {
        case .alert:
            self.alert(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert),actions: {
                alert.wrappedValue?.buttons()
            }, message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            })
        case .confirmationDialog:
            self.confirmationDialog(alert.wrappedValue?.title ?? "", isPresented: Binding(ifNotNil: alert),actions: {
                alert.wrappedValue?.buttons()
            }, message: {
                if let subtitle = alert.wrappedValue?.subtitle {
                    Text(subtitle)
                }
            })
        }
    }
}
