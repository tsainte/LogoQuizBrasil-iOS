//
//  AboutCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

protocol AboutCoordinatorDelegate: class {

}
class AboutCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow

    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window
    }

}

extension AboutCoordinator: Coordinator {

    func start() {
        guard let aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController else {
            fatalError("Can't instantiate AboutViewController")
        }
        let viewModel = AboutViewModel(viewModelDelegate: aboutVC, coordinatorDelegate: self)
        aboutVC.viewModel = viewModel

        (window.rootViewController as? UINavigationController)?.pushViewController(aboutVC, animated: true)
    }

}

extension AboutCoordinator: AboutCoordinatorDelegate {
    
}
