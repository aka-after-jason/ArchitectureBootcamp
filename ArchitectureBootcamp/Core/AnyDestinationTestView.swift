//
//  ExploreView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/8.
//

import SwiftUI

struct AnyDestinationTestView: View {
    @Environment(\.router) private var router
    var body: some View {
        List {
            segueSection
            alertSection
            modalSection
        }
        .navigationTitle("Routing example")
    }
    
    private var modalSection: some View {
        Section(
            content: {
                Button(
                    action: {
                        router.showModal(
                            backgroundColor: Color.red.opacity(0.4),
                            transition: .move(edge: .top),
                            destination: {
                                RoundedRectangle(cornerRadius: 30)
                                    .fill(Color.blue)
                                    .frame(width: 250, height: 400)
                                    .onTapGesture {
                                        router.dismissModal()
                                    }
                            })
                    },
                    label: {
                        Text("ShowModal")
                    })
                Button(action: {
                    router.dismissModal()
                }, label: {
                    Text("Dismiss Modal")
                })
            },
            header: {
            Text("Modal")
        })
    }
    
    private var alertSection: some View {
        Section(content: {
            Button(action: {
                router.showAlert(type: .alert, title: "Title", subtitle: "Subtitle", buttons: nil)
            }, label: {
                Text("Alert")
            })
            Button(action: {
                router.showAlert(type: .confirmationDialog, title: "Title", subtitle: "subtitle", buttons: {
                    AnyView(
                        Group {
                            Button("Alpha") {}
                            Button("Beta") {}
                            Button("Gamma") {}
                            Button("Delta") {}
                        }
                    )
                })
            }, label: {
                Text("ConfirmationDialog")
            })
            Button(action: {
                router.dismissAlert()
            }, label: {
                Text("Dismiss Alert")
            })
        }, header: {
            Text("Alerts")
        })
    }
    
    private var segueSection: some View {
        Section(content: {
            Button(action: {
                router.showScreen(.push) { _ in
                    AnyDestinationTestView()
                }
            }, label: {
                Text("push")
            })
            Button(action: {
                router.showScreen(.sheet) { _ in
                    AnyDestinationTestView()
                }
            }, label: {
                Text("sheet")
            })
            Button(action: {
                router.showScreen(.fullScreenCover) { _ in
                    AnyDestinationTestView()
                }
            }, label: {
                Text("full screen cover")
            })
            Button(action: {
                router.dismissScreen()
            }, label: {
                Text("dismiss")
            })
        }, header: {
            Text("Segues")
        })
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
    RouterView { _ in
        AnyDestinationTestView()
    }
}
