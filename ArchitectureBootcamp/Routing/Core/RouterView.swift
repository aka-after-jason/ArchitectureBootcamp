//
//  RouterView.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

/**
 SWIFTUI view 的层级关系, Parent-child
 
 RouterView - @Environment 是放在 RouterView 里面的
    SettingsView
        AccountView 如果这里需要dismiss, 则需要对应的 @Environment
        
 */
struct RouterView<Content: View>: View, Router {
    @Environment(\.dismiss) private var dismiss
    
    @State private var path: [AnyDestination] = []
    
    @State private var showSheet: AnyDestination? = nil
    @State private var showFullScreenCover: AnyDestination? = nil
    
    @State private var alert: AnyAppAlert? = nil
    @State private var alertType: AlertType = .alert
    
    /// Binding to the view stack from previous RouterView
    @Binding var screenStack: [AnyDestination]
    
    var addNavigationView: Bool // 标识
    
    @ViewBuilder var content: (Router) -> Content
    
    init(
        screenStack: Binding<[AnyDestination]>? = nil,
        addNavigationView: Bool = true,
        content: @escaping (Router) -> Content
    ) {
        // 这里需要使用_screenStack
        self._screenStack = screenStack ?? .constant([])
        self.addNavigationView = addNavigationView
        self.content = content
    }
    
    var body: some View {
        // 关键代码
        NavigationStackIfNeeded(path: $path, addNavigationView: addNavigationView) {
            content(self) // 统一管理, 添加 modifier 的话不再需要添加两遍
                .sheetViewModifier(screen: $showSheet)
                .fullScreenCoverViewModifier(screen: $showFullScreenCover)
                .showCustomAlert(type: alertType, alert: $alert)
        }
        .environment(\.router, self) // 将 router 放入环境
    }
    
    /// 每次创建新screen的时候, 创建一个新的 RouterView 和 新的 @Environment(\.dismiss)
    /// 因为 @Environment(\.dismiss) 是在 RouterView 里面的
    /// 哪个页面需要 dismiss, 哪个页面就需要 @Environment(\.dismiss) 这个
    func showScreen<T: View>(_ option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T) {
        // 关键代码
        // 创建新的 RouterView
        let newScreen = RouterView<T>(
            // screenStack 为空表示 first RouterView, 使用 $path, 否则 使用 $screenStack
            screenStack: option.shouldAddNewNavigationView ? nil : (screenStack.isEmpty ? $path : $screenStack),
            addNavigationView: option.shouldAddNewNavigationView
        ) { newRouter in
            destination(newRouter) // 返回 router
        }
        
        let destination = AnyDestination(destination: newScreen)
        
        switch option {
        case .push:
            if screenStack.isEmpty {
                // this means we are in the first RouterView
                path.append(destination)
            } else {
                // this means we are in the secondary RouterView
                screenStack.append(destination)
            }

        case .sheet:
            showSheet = destination
        case .fullScreenCover:
            showFullScreenCover = destination
        }
    }
    
    
    /// dismiss screen
    func dismissScreen() {
        dismiss()
    }
    
    
    /// Show Alert
    /// - Parameters:
    ///   - type: alert, confirmationDialog
    ///   - title: title
    ///   - subtitle: subtitle
    ///   - buttons: buttons
    func showAlert(type: AlertType, title: String, subtitle: String? = nil, buttons: (() -> AnyView)? = nil) {
        alertType = type
        alert = AnyAppAlert(title: title, subtitle: subtitle, buttons: buttons)
    }
    
    
    /// dismiss alert
    func dismissAlert() {
        alert = nil
    }
}
