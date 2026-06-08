//
//  ExploreView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/8.
//

import SwiftUI

struct ExploreView: View {
    var body: some View {
        RouterView { router in
            VStack {
                Button(action: {
                    router.showScreen(destination: {
                        Text("123456")
                    })
                }, label: {
                    Text("Click me")
                })
            }
        }
    }
}

#Preview {
    ExploreView()
}
