//
//  MenuCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

protocol MenuCoordinatorDelegate {
    func goToPlay()
    func goToBoard()
    func goToAbout()
}

struct MenuCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow
    let childCoordinators: [String: Coordinator]

    struct Coordinators {
        static let levelList = "LevelListCoordinator"
        static let about = "About"
    }

    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window

        childCoordinators = [
            Coordinators.levelList : LevelListCoordinator(storyboard: storyboard, window: window),
            Coordinators.about : AboutCoordinator(storyboard: storyboard, window: window)
        ]
    }
}

extension MenuCoordinator: Coordinator {
    func start() {
        guard let navigationVC = storyboard.instantiateViewController(withIdentifier: "NavigationController")
            as? UINavigationController else {
            fatalError("Can't instantiate navigation controller from storyboard")
        }
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewController")
            as? MenuViewController else {
            fatalError("Can't instantiate menu view controller")
        }

        let menuVM = MenuViewModel(viewModelDelegate: menuVC, coordinatorDelegate: self)
        menuVC.viewModel = menuVM

        navigationVC.viewControllers = [menuVC]

        window.rootViewController = navigationVC
        window.makeKeyAndVisible()
    }
}

// MARK: Navigation from view model
extension MenuCoordinator: MenuCoordinatorDelegate {
    func goToPlay() {
        let coordinator = childCoordinators[Coordinators.levelList]
        coordinator?.start()
    }

    func goToBoard() {

    }

    func goToAbout() {
        let coordinator = childCoordinators[Coordinators.about]
        coordinator?.start()
    }
}
