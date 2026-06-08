//
//  AnyDestination.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/8.
//
import SwiftUI

// 使用 枚举的方式是列出所有的 destination
/*
enum NavigationDestinationOption: Hashable {
    case integerScreen(int: Int)
    case stringScreen(string: String)
    case someOtherScreen(bool: Bool)
}
 */


/// 这种方式更加灵活, 推荐使用
struct AnyDestination: Hashable {
    let id = UUID().uuidString
    var destination: AnyView
    
    /// destination 表示 view
    init<T: View>(destination: T) {
        self.destination = AnyView(destination)
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: AnyDestination, rhs: AnyDestination) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
}

/// 将 Router 放入到 环境当中
/// 使用: @Environment(\.router) private var router
extension EnvironmentValues {
    @Entry var router: Router = MockRouter()
}

protocol Router {
    /// 接收一个 ViewBuilder 的参数, 类型是一个泛型函数
    func showScreen<T: View>(@ViewBuilder destination: @escaping (Router) -> T)
    func dismissScreen()
}

/// 用作默认值
struct MockRouter: Router {
    func showScreen<T>(destination: @escaping (any Router) -> T) where T : View {
        print("Mock router does not work.")
    }
    
    func dismissScreen() {
        print("Mock router does not work.")
    }
}

/**
 SWIFTUI view 的层级关系, Parent-child
 
 RouterView - @Environment 是放在 RouterView 里面的
    SettingsView
        AccountView 如果这里需要dismiss, 则需要对应的 @Environment
        
 */
struct RouterView<Content: View>: View, Router {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var path: [AnyDestination] = []
    
    // Binding to the view stack from previous RouterView
    @Binding var screenStack: [AnyDestination]
    
    var addNavigationView: Bool // 标识
    
    @ViewBuilder var content: (Router) -> Content
    
    init(
        screenStack: (Binding<[AnyDestination]>)? = nil,
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
        }
        .environment(\.router, self) // 将 router 放入环境
    }
    
    /// 每次创建新screen的时候, 创建一个新的 RouterView 和 新的 @Environment(\.dismiss)
    /// 因为 @Environment(\.dismiss) 是在 RouterView 里面的
    /// 哪个页面需要 dismiss, 哪个页面就需要 @Environment(\.dismiss) 这个
    func showScreen<T: View>(@ViewBuilder destination: @escaping (Router) -> T) {
        // 关键代码
        // 创建新的 RouterView
        let newScreen = RouterView<T>(
            // screenStack 为空表示 first RouterView, 使用 $path, 否则 使用 $screenStack
            screenStack: screenStack.isEmpty ? $path : $screenStack,
            addNavigationView: false
        ) { newRouter in
            destination(newRouter) // 返回 router
        }
        
        let destination = AnyDestination(destination: newScreen)
        
        if screenStack.isEmpty {
            // this means we are in the first RouterView
            path.append(destination)
        } else {
            // this means we are in the secondary RouterView
            screenStack.append(destination)
        }
    }
    
    func dismissScreen() {
        dismiss()
    }
}

struct NavigationStackIfNeeded<Content: View>: View {
    @Binding var path: [AnyDestination]
    var addNavigationView: Bool = true
    @ViewBuilder var content: Content
    var body: some View {
        if addNavigationView {
            NavigationStack(path: $path) {
                content
                    .navigationDestination(for: AnyDestination.self) { value in
                        value.destination
                    }
            }
        } else {
            content
        }
    }
}
