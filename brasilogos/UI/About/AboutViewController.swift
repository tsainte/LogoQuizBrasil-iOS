//
//  AboutViewController.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var evaluateButton: UIButton! {
        didSet {
            evaluateButton.round()
        }
    }
    @IBOutlet weak var sendEmailButton: UIButton! {
        didSet {
            sendEmailButton.round()
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
