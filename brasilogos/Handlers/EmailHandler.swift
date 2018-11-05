//
//  EmailHandler.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 09/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import MessageUI

class EmailHandler: NSObject {

    let subject: String
    let message: String
    let recipients: [String]

    let toaster: Toaster

    init(subject: String, message: String, recipients: [String], toaster: Toaster) {
        self.subject = subject
        self.message = message
        self.recipients = recipients
        self.toaster = toaster
    }

    func mailComposer() -> MFMailComposeViewController {
        let mail = MFMailComposeViewController()
        mail.mailComposeDelegate = self
        mail.setSubject(subject)
        mail.setMessageBody(message, isHTML: false)
        mail.setToRecipients(recipients)
        return mail
    }
}

extension EmailHandler: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController,
                               didFinishWith result: MFMailComposeResult,
                               error: Error?) {
        switch result {
        case .sent:
            toaster.toast(message: "Email enviado")
        case .saved:
            toaster.toast(message: "Email salvo")
        case .failed:
            toaster.toast(message: "Oops, email não pode ser enviado")
        case .cancelled:
            toaster.toast(message: "Email cancelado")
        }
        controller.dismiss(animated: true, completion: nil)
    }
}
