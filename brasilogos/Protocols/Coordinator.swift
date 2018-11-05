//
//  Coordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

protocol Coordinator {
    func start()
}

protocol ViewCoordinator: Coordinator {
    var window: UIWindow { get }
    var storyboard: UIStoryboard { get }
    func push(to viewController: UIViewController)
}

extension ViewCoordinator {
    func push(to viewController: UIViewController) {
        if let navigationController = window.rootViewController as? UINavigationController {
            navigationController.pushViewController(viewController, animated: true)
        }
    }
}
