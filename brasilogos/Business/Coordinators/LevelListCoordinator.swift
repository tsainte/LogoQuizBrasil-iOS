//
//  LevelListCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

struct LevelListCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow
    let levelListVC: LevelListViewController
    let logoStorage: LogoStorage

    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window

        // load storyboard
        guard let levelListVC = storyboard.instantiateViewController(withIdentifier: "LevelListViewController")
            as? LevelListViewController else {
            fatalError("Can't instantiate LevelListViewController")
        }
        self.levelListVC = levelListVC

        //load logo data
        guard let dbFileURL = Bundle.main.url(forResource: "db", withExtension: "json") else {
            fatalError("Can't load json with the logos")
        }
        do {
            self.logoStorage = try LogoStorage(fileURL: dbFileURL)
        } catch let error {
            fatalError("Can't parse json with logos: \(error.localizedDescription)")
        }
    }
}

extension LevelListCoordinator: ViewCoordinator {
    func start() {
        let viewModel = LevelListViewModel(delegate: levelListVC, levels: logoStorage.levels)
        levelListVC.viewModel = viewModel
        push(to: levelListVC)
    }
}
