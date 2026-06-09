//
//  ProfileView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/8.
//

import SwiftUI

struct ProfileView: View {
    // @State private var path: [NavigationDestinationOption] = .init()
    @State private var path: [AnyDestination] = []
    var body: some View {
        NavigationStack(path: $path) {
            VStack(spacing: 40) {
                Button(action: {
                    // path.append(.stringScreen(string: "string value"))
                    path.append(AnyDestination(destination: Text("string value")))
                }, label: {
                    Text("Click me")
                })
                
                Button(action: {
                    // path.append(.integerScreen(int: 123))
                    path.append(AnyDestination(destination: Text("\(123)")))
                }, label: {
                    Text("Click me")
                })
                
                Button(action: {
                    // path.append(.someOtherScreen(bool: true))
                    path.append(AnyDestination(destination: Text("true")))
                }, label: {
                    Text("Click me")
                })
                
                Button(action: {
                    // gotoMVVMDIView()
                }, label: {
                    Text("Go to ContentView")
                })
            }
            .navigationDestination(for: AnyDestination.self) { value in
                value.destination
            }
            /*
             .navigationDestination(for: NavigationDestinationOption.self) { option in
                 switch option {
                 case .integerScreen(int: let int):
                     Text("\(int)")
                 case .stringScreen(string: let str):
                     Text(str)
                 case .someOtherScreen(bool: let bool):
                     Text(bool.description)
                 }
             }
              */
        }
    }
    
//    func gotoMVVMDIView() {
//        let container = DependencyContainer()
//        container.regiser(DataManager.self, manager: DataManager(service: MockDataService()))
//        container.regiser(UserManager.self, manager: UserManager())
//        path.append(AnyDestination(
//            destination: MVVMDIView(viewModel: MVVMDIViewModel(interactor: CoreInteractor(container: container)))
//        ))
//    }
}

#Preview {
    ProfileView()
}
