//
//  LevelListCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LevelListCoordinator: NSObject {
    
    let storyboard: UIStoryboard
    let window: UIWindow
    let levelListVC: LevelListViewController
    let logoStorage = LogoStorage()
    
    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window
        guard let levelListVC = storyboard.instantiateViewController(withIdentifier: "LevelListViewController") as? LevelListViewController else {
            fatalError("Can't instantiate LevelListViewController")
        }
        self.levelListVC = levelListVC
    }
}

extension LevelListCoordinator: ViewCoordinator {
    func start() {
        let viewModel = LevelListViewModel(delegate: levelListVC, levels: logoStorage.levels)
        levelListVC.viewModel = viewModel
        push(to: levelListVC)
    }
}
