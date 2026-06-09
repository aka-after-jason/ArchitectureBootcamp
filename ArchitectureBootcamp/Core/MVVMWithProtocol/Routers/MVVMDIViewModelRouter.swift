//
//  MVVMDIViewModelRouter.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

protocol MVVMDIViewModelRouter {
    func gotoProductView(product: Product)
}

extension CoreRouter: MVVMDIViewModelRouter {}
