//
//  MenuViewController.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit
class MenuViewController: UIViewController {

    var viewModel: MenuViewModelType!
    
    @IBOutlet weak var playButton: CustomUIButton!
    @IBOutlet weak var boardButton: CustomUIButton!
    @IBOutlet weak var aboutButton: CustomUIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: Actions
extension MenuViewController {
    @IBAction func playTapped() {
        viewModel.playDidTapped()
    }
    @IBAction func boardTapped() {
        viewModel.boardDidTapped()
    }
    @IBAction func aboutTapped() {
        viewModel.aboutDidTapped()
    }
}

// MARK: View Model Delegate
extension MenuViewController: MenuViewModelDelegate { }
