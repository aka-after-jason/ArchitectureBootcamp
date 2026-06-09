//
//  Router.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

/// 将 Router 放入到 环境当中
/// 使用: @Environment(\.router) private var router
extension EnvironmentValues {
    @Entry var router: Router = MockRouter()
}


protocol Router {
    /// 接收一个 ViewBuilder 的参数, 类型是一个泛型函数
    func showScreen<T: View>(_ option: SegueOption, @ViewBuilder destination: @escaping (Router) -> T)
    func dismissScreen()
    
    func showAlert(type: AlertType, title: String, subtitle: String?, buttons: (() -> AnyView)?)
    func dismissAlert()
}

/// 用作默认值
struct MockRouter: Router {
    func showScreen<T: View>(_ option: SegueOption, @ViewBuilder destination _: @escaping (Router) -> T) {
        print("Mock router does not work.")
    }
    
    func dismissScreen() {
        print("Mock router does not work.")
    }
    
    func showAlert(type: AlertType, title: String, subtitle: String?, buttons: (() -> AnyView)?) {
        print("Mock router does not work.")
    }
    
    func dismissAlert() {
        print("Mock router does not work.")
    }
}
