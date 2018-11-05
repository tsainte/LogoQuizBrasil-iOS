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
    var evaluateButton: String { get }
    var sendEmailButton: String { get }
}
protocol AboutViewModelActions {
    func evaluateTapped()
    func sendEmailTapped()
}
protocol AboutViewModelDelegate: class { }

class AboutViewModel: ViewModel {

    weak var viewModelDelegate: AboutViewModelDelegate?
    let coordinatorDelegate: AboutCoordinatorDelegate
    init(viewModelDelegate: AboutViewModelDelegate,
         coordinatorDelegate: AboutCoordinatorDelegate) {
        self.viewModelDelegate = viewModelDelegate
        self.coordinatorDelegate = coordinatorDelegate
    }
}

extension AboutViewModel: AboutViewModelBindings {
    var labelTop: String {
        return NSLocalizedString("AboutViewModel:label:TOP", comment: "")
    }

    var labelBottom: String {
        return NSLocalizedString("AboutViewModel:label:BOTTOM", comment: "")
    }

    var evaluateButton: String {
        return NSLocalizedString("AboutViewModel:button:EVALUATE", comment: "")
    }

    var sendEmailButton: String {
        return NSLocalizedString("AboutViewModel:button:SEND_EMAIL", comment: "")
    }
}
extension AboutViewModel: AboutViewModelActions {
    func evaluateTapped() {
        coordinatorDelegate.goToEvaluate()
    }

    func sendEmailTapped() {
        coordinatorDelegate.goToEmail()
    }
}
