//
//  LevelListTableViewManager.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LevelListTableViewManager: NSObject {
    
    let tableView: UITableView
    weak var dataProvider: LevelListDataProvider?
    var viewModel: LevelListDataProvider
    
    init(tableView: UITableView, viewModel: LevelListDataProvider) {
        self.tableView = tableView
        self.viewModel = viewModel
        super.init()
        
        tableView.dataSource = self
    }
}

extension LevelListTableViewManager: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayModel = viewModel.displayModel(for: indexPath.row)
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        
        return cell
    }
}


