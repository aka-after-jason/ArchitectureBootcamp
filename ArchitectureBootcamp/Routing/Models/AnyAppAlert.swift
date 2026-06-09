//
//  AnyAppAlert.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

struct AnyAppAlert {
    var title: String
    var subtitle: String?
    var buttons: () -> AnyView
    
    // init 1
    init(title: String, subtitle: String? = nil, buttons: (() -> AnyView)? = nil) {
        self.title = title
        self.subtitle = subtitle
        self.buttons = buttons ?? {
            AnyView(Button("Ok", action: {}))
        }
    }
    
    // init 2
    init(error: Error) {
        self.init(title: "Error", subtitle: error.localizedDescription, buttons: nil)
    }
}
