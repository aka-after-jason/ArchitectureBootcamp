//
//  ModalViewModifier.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

struct ModalSupportView<Content: View>: View {
    let backgroundColor: Color
    let transition: AnyTransition
    @Binding var showModal: Bool
    @ViewBuilder var content: Content
    var body: some View {
        ZStack {
            if self.showModal {
                // 背景在下面
                self.backgroundColor
                    .ignoresSafeArea()
                    .transition(AnyTransition.opacity.animation(.smooth))
                    .onTapGesture {
                        self.showModal = false
                    }
                    .zIndex(1)

                // 内容在上面
                self.content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
                    .transition(self.transition)
                    .zIndex(2) // zIndex 的值越大,越在上面
            }
        }
        .zIndex(9999) // 表示该view在最上面
        .animation(.bouncy, value: self.showModal)
    }
}

extension View {
    // 关键代码
    func modalViewModifier(
        backgroundColor: Color,
        transition: AnyTransition,
        screen: Binding<AnyDestination?>
    ) -> some View {
        self
            .overlay {
                ModalSupportView(
                    backgroundColor: backgroundColor,
                    transition: transition,
                    showModal: Binding(ifNotNil: screen)
                ) {
                    ZStack {
                        if let screen = screen.wrappedValue {
                            screen.destination
                        }
                    }
                }
            }
    }
}
