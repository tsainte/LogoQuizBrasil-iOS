//
//  ApplicationCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

//TODO: Consider convert to struct once we finish migration to swift
class ApplicationCoordinator: NSObject {

    let window: UIWindow
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    var childCoordinator: Coordinator?

    @objc init(window: UIWindow) {
        self.window = window
    }
}

extension ApplicationCoordinator: Coordinator {

    @objc func start() {
        childCoordinator = MenuCoordinator(storyboard: storyboard, window: window)
        childCoordinator?.start()
    }
}
