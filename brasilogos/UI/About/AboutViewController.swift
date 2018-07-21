//
//  AboutViewController.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var evaluateButton: CustomUIButton! {
        didSet {
            evaluateButton.setTitle(viewModel.evaluateButton,
                                    for: .normal)
        }
    }
    @IBOutlet weak var sendEmailButton: CustomUIButton! {
        didSet {
            sendEmailButton.setTitle(viewModel.sendEmailButton,
                                     for: .normal)
        }
    }

    @IBOutlet weak var labelTop: UILabel! {
        didSet {
            labelTop.text = viewModel.labelTop
        }
    }
    @IBOutlet weak var labelBottom: UITextView! {
        didSet {
           labelBottom.text = viewModel.labelBottom
        }
    }
    var viewModel: AboutViewModelType!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func evaluateTapped() {
        viewModel.evaluateTapped()
    }
    
    @IBAction func sendEmailTapped() {
        viewModel.sendEmailTapped()
    }
}

extension AboutViewController: AboutViewModelDelegate {

}
