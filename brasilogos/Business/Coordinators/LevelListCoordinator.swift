//
//  LevelListCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

protocol LevelListCoordinatorDelegate {
    func goToLevel(_ level: Int)
    func goToShopping()
}

struct LevelListCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow
    let childCoordinators: [String: Coordinator]

    struct Coordinators {
        static let level = "level"
        static let shopping = "shopping"
    }

    let logoStorage: LogoStorage

    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window

        //load logo data
        guard let dbFileURL = Bundle.main.url(forResource: "db", withExtension: "json") else {
            fatalError("Can't load json with the logos")
        }
        do {
            self.logoStorage = try LogoStorage(fileURL: dbFileURL)
        } catch let error {
            fatalError("Can't parse json with logos: \(error.localizedDescription)")
        }

        //initialise child coordinators
        childCoordinators = [
            Coordinators.level : LevelCoordinator(storyboard: storyboard, window: window),
            Coordinators.shopping : ShoppingCoordinator(storyboard: storyboard, window: window)
        ]
    }
}

extension LevelListCoordinator: ViewCoordinator {
    func start() {
        // 1. Load view from storyboard
        guard let levelListVC = storyboard.instantiateViewController(withIdentifier: "LevelListViewController")
            as? LevelListViewController else {
                fatalError("Can't instantiate LevelListViewController")
        }

        // 2. Inject view model
        let viewModel = LevelListViewModel(delegate: levelListVC,
                                           coordinator: self,
                                           levels: logoStorage.levels)
        levelListVC.viewModel = viewModel

        // 3. Navigate
        push(to: levelListVC)
    }
}

extension LevelListCoordinator: LevelListCoordinatorDelegate {
    func goToLevel(_ level: Int) {
        guard var coordinator = childCoordinators[Coordinators.level] as? LevelCoordinator else {
            fatalError("Can't retrieve level coordinator")
        }
        coordinator.level = logoStorage.levels[level-1]
        coordinator.start()
    }

    func goToShopping() {
        let coordinator = childCoordinators[Coordinators.shopping]
        coordinator?.start()
    }
}
