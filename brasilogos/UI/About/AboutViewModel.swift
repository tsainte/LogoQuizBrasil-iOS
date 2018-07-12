//
//  AboutViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

typealias AboutViewModelType = AboutViewModelBindings & AboutViewModelActions
protocol AboutViewModelBindings {
    var labelTop: String { get }
    var labelBottom: String { get }
}
protocol AboutViewModelActions {
    func evaluateTapped()
    func sendEmailTapped()
}
protocol AboutViewModelDelegate: class { }

class AboutViewModel: NSObject {

    weak var viewModelDelegate: AboutViewModelDelegate?
    weak var coordinatorDelegate: AboutCoordinatorDelegate?
    init(viewModelDelegate: AboutViewModelDelegate,
         coordinatorDelegate: AboutCoordinatorDelegate) {
        self.viewModelDelegate = viewModelDelegate
        self.coordinatorDelegate = coordinatorDelegate
    }
}

extension AboutViewModel: AboutViewModelBindings {
    var labelTop: String {
        return NSLocalizedString("AboutViewModel:label:TOP", comment: "nil")
    }
    
    var labelBottom: String {
        return NSLocalizedString("AboutViewModel:label:BOTTOM", comment: "nil")
    }
}
extension AboutViewModel: AboutViewModelActions {
    func evaluateTapped() {
        coordinatorDelegate?.goToEvaluate()
    }

    func sendEmailTapped() {
        coordinatorDelegate?.goToEmail()
    }
}
