//
//  LevelListViewController.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LevelListViewController: UIViewController {

    var viewModel: LevelListViewModelType!
    var tableViewManager: LevelListTableViewManager!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableViewManager = LevelListTableViewManager(tableView: tableView,
                                                     dataProvider: viewModel as LevelListDataProvider,
                                                     actions: viewModel as LevelListActions)
    }
}

extension LevelListViewController: LevelListViewModelDelegate {
    func showMessage(_ message: String) {
        view.makeToast(message)
    }
}
