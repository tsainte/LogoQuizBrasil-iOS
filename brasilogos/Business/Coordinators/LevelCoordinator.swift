//
//  LevelCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

protocol LevelCoordinatorDelegate {
    func goToLogo()
}

struct LevelCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow
    let childCoordinators: [String: Coordinator]

    var level: Level!
    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window

        //initialise child coordinators
        childCoordinators = [
            "shopping" : ShoppingCoordinator(storyboard: storyboard, window: window)
        ]
    }
}

extension LevelCoordinator : ViewCoordinator {
    func start() {
        // 1. Load view from storyboard
        guard let levelVC = storyboard.instantiateViewController(withIdentifier: "LevelViewController")
            as? LevelViewController else {
                fatalError("Can't instantiate LevelListViewController")
        }

        // 2. Inject view model
        let viewModel = LevelViewModel(delegate: levelVC,
                                           coordinator: self,
                                           level: level)
        levelVC.viewModel = viewModel

        // 3. Navigate
        push(to: levelVC)

    }
}

extension LevelCoordinator: LevelCoordinatorDelegate {
    func goToLogo() {

    }
}
