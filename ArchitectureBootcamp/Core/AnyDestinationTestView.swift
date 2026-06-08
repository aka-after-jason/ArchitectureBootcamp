//
//  ExploreView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/8.
//

import SwiftUI

struct AnyDestinationTestView: View {
    var body: some View {
        RouterView { router in
            VStack {
                Button(action: {
                    router.showScreen(.sheet, destination: { _ in
                        SettingsView()
                    })
                }, label: {
                    Text("Click me")
                })
            }
        }
    }
}

struct SettingsView: View {
    @Environment(\.router) private var router
    var body: some View {
        VStack {
            Text("SettingsView")
            Button(action: {
                router.showScreen(.push, destination: { _ in
                    AccountView()
                })
            }, label: {
                Text("Next")
            })
        }
        .navigationTitle("Settings")
    }
}

struct AccountView: View {
    @Environment(\.router) private var router
    var body: some View {
        VStack {
            Text("AccountView")
            Button(action: {
                router.showScreen(.fullScreenCover) { _ in
                    AccountView()
                }
            }, label: {
                Text("Next")
            })
            Button(action: {
                router.dismissScreen()
            }, label: {
                Text("Dismiss")
            })
        }
        .navigationTitle("Account")
    }
}

#Preview {
    AnyDestinationTestView()
}
