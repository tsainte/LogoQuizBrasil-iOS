//
//  AboutCoordinator.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit
import MessageUI

protocol AboutCoordinatorDelegate: class {
    func goToEvaluate()
    func goToEmail()
}

class AboutCoordinator {

    let storyboard: UIStoryboard
    let window: UIWindow

    let aboutVC: AboutViewController
    var emailHandler: EmailHandler!

    init(storyboard: UIStoryboard, window: UIWindow) {
        self.storyboard = storyboard
        self.window = window
        guard let aboutVC = storyboard.instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController else {
            fatalError("Can't instantiate AboutViewController")
        }
        self.aboutVC = aboutVC
    }

}

extension AboutCoordinator: ViewCoordinator {
    func start() {
        let viewModel = AboutViewModel(viewModelDelegate: aboutVC, coordinatorDelegate: self)
        aboutVC.viewModel = viewModel
        push(to: aboutVC)
    }
}

extension AboutCoordinator: AboutCoordinatorDelegate {
    func goToEvaluate() {
        guard let appID = Bundle.main.infoDictionary?["AppId"],
            let url = URL(string: "itms-apps://itunes.apple.com/app/id\(appID)")
            else {
            return
        }
        UIApplication.shared.openURL(url)
    }

    func goToEmail() {
        if MFMailComposeViewController.canSendMail() {
            emailHandler = EmailHandler(subject: NSLocalizedString("AboutCoordinator:Email:SUBJECT", comment: ""),
                                        message: "",
                                        recipients: ["ios@mobwiz.com.br"],
                                        toaster: self)
            aboutVC.present(emailHandler.mailComposer(), animated: true, completion: nil)
        } else {
            toast(message: NSLocalizedString("AboutCoordinator:Email:NOT_CONFIGURED", comment: ""))
        }
    }
}

extension AboutCoordinator: Toaster {
    func toast(message: String) {
        aboutVC.view.makeToast(message)
    }
}

