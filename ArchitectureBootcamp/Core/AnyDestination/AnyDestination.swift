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

protocol Router {
    /// 接收一个 ViewBuilder 的参数, 类型是一个泛型函数
    func showScreen<T: View>(@ViewBuilder destination: () -> T)
}

struct RouterView<Content: View>: View, Router {
    @State private var path: [AnyDestination] = []
    @ViewBuilder var content: (Router) -> Content
    var body: some View {
        NavigationStack(path: $path) {
            content(self)
                .navigationDestination(for: AnyDestination.self) { value in
                    value.destination
                }
        }
    }
    
    func showScreen<T: View>(@ViewBuilder destination: () -> T) {
        let destination = AnyDestination(destination: destination())
        path.append(destination)
    }
}
