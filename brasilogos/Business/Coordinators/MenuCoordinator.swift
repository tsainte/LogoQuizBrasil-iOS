//
//  MenuCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

protocol MenuCoordinatorDelegate: class {
    func goToPlay()
    func goToBoard()
    func goToAbout()
}

class MenuCoordinator: NSObject {

    let storyboard: UIStoryboard
    let window: UIWindow
    var childCoordinators: [String: Coordinator] = [:]
    
    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window
    }
}

extension MenuCoordinator: Coordinator {
    func start() {
        guard let navigationVC = storyboard.instantiateViewController(withIdentifier: "NavigationController") as? UINavigationController else {
            fatalError("Can't instantiate navigation controller from storyboard")
        }
        guard let menuVC = storyboard.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController else {
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
        let levelListCoordinator = LevelListCoordinator(storyboard: storyboard, window: window)
        childCoordinators["levelList"] = levelListCoordinator
        levelListCoordinator.start()
    }

    func goToBoard() {

    }

    func goToAbout() {
        let aboutCoordinator = AboutCoordinator(storyboard: storyboard, window: window)
        childCoordinators["about"] = aboutCoordinator
        aboutCoordinator.start()
    }
}
