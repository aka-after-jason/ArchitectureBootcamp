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
                    router.showScreen(destination: { router in
                        SettingsView(router: router)
                    })
                }, label: {
                    Text("Click me")
                })
            }
        }
    }
}

struct SettingsView: View {
    let router: Router
    var body: some View {
        VStack {
            Text("SettingsView")
            Button(action: {
                router.showScreen(destination: { router in
                    AccountView(router: router)
                })
            }, label: {
                Text("Next")
            })
        }
        .navigationTitle("Settings")
    }
}

struct AccountView: View {
    let router: Router
    var body: some View {
        VStack {
            Text("AccountView")
            Button(action: {
                router.showScreen { router in
                    AccountView(router: router)
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
    ExploreView()
}
