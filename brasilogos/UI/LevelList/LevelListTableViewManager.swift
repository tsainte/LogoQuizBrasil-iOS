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
    var dataProvider: LevelListDataProvider
    var actions: LevelListActions

    init(tableView: UITableView, dataProvider: LevelListDataProvider, actions: LevelListActions) {
        self.tableView = tableView
        self.dataProvider = dataProvider
        self.actions = actions
        super.init()

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension LevelListTableViewManager: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataProvider.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let displayModel = dataProvider.displayModel(for: indexPath.row)
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LevelTableViewCell")
            as? LevelTableViewCell else {
            fatalError("Can't dequeue LevelTableViewCell")
        }
        cell.configure(with: displayModel)

        return cell
    }
}

extension LevelListTableViewManager: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        actions.userDidTapped(index: indexPath.row)
    }
}
