//
//  ShoppingCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

protocol ShoppingCoordinatorDelegate {
    func dismiss()
}

struct ShoppingCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow
    let childCoordinators: [String: Coordinator] = [:]
}

extension ShoppingCoordinator : Coordinator {
    func start() { }
}
