//
//  CoreRouter.swift
//  ArchitectureBootcamp
//
//  Created by Elaine on 2026/6/9.
//
import SwiftUI

struct CoreRouter {
    let router: Router
    
    func gotoProductView(product: Product) {
        router.showScreen(.push) { _ in
            Text(product.title)
        }
    }
}
