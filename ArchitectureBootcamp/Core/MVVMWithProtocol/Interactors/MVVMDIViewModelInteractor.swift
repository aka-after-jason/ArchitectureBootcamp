//
//  MVVMDIViewModelInteractor.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/2.
//
import SwiftUI

/// 这个协议中只存储需要用到的方法
protocol MVVMDIViewModelInteractor {
    func getProducts() async throws -> [Product]
    func getUser() async throws -> String
}

extension CoreInteractor: MVVMDIViewModelInteractor {}
