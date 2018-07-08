//
//  MenuViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

typealias MenuViewModelType = MenuViewModelBindings & MenuViewModelActions

protocol MenuViewModelBindings { }
protocol MenuViewModelActions {
    func playDidTapped()
    func boardDidTapped()
    func aboutDidTapped()
}

protocol MenuViewModelDelegate: class { }

class MenuViewModel {

    weak var viewModelDelegate: MenuViewModelDelegate?
    weak var coordinatorDelegate: MenuCoordinatorDelegate?

    init(viewModelDelegate: MenuViewModelDelegate, coordinatorDelegate: MenuCoordinatorDelegate) {
        self.viewModelDelegate = viewModelDelegate
        self.coordinatorDelegate = coordinatorDelegate
    }
}

extension MenuViewModel: MenuViewModelBindings { }
extension MenuViewModel: MenuViewModelActions {
    func playDidTapped() {
        coordinatorDelegate?.goToPlay()
    }

    func boardDidTapped() {
        coordinatorDelegate?.goToBoard()
    }

    func aboutDidTapped() {
        coordinatorDelegate?.goToAbout()
    }
}
