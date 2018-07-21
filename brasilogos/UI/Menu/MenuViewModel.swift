//
//  MenuViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

typealias MenuViewModelType = MenuViewModelBindings & MenuViewModelActions

protocol MenuViewModelBindings {
    var playButton: String { get }
    var boardButton: String { get }
    var aboutButton: String { get }
}
protocol MenuViewModelActions {
    func playDidTapped()
    func boardDidTapped()
    func aboutDidTapped()
}

protocol MenuViewModelDelegate: class { }

class MenuViewModel: ViewModel {

    weak var viewModelDelegate: MenuViewModelDelegate?
    weak var coordinatorDelegate: MenuCoordinatorDelegate?

    init(viewModelDelegate: MenuViewModelDelegate, coordinatorDelegate: MenuCoordinatorDelegate) {
        self.viewModelDelegate = viewModelDelegate
        self.coordinatorDelegate = coordinatorDelegate
    }
}

extension MenuViewModel: MenuViewModelBindings {
    var playButton: String {
        return NSLocalizedString("MenuViewModel:button:PLAY", comment: "")
    }
    
    var boardButton: String {
        return NSLocalizedString("MenuViewModel:button:BOARD", comment: "")
    }
    
    var aboutButton: String {
        return NSLocalizedString("MenuViewModel:button:ABOUT", comment: "")
    }
    
    
}
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
