//
//  LevelListViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LevelDataModel {
    init(level: Level) {
    }
}

typealias LevelListViewModelType = LevelListDataProvider & LevelListActions

protocol LevelListDataProvider: class {
    var numberOfRows: Int { get }
    func displayModel(for index: Int) -> LevelDataModel
}

protocol LevelListActions {}

class LevelListViewModel: ViewModel {
    
    weak var delegate: LevelListViewController?
    let levelDataModels: [LevelDataModel]
    init(delegate: LevelListViewController, levels: [Level]) {
        self.delegate = delegate
        levelDataModels = levels.map { LevelDataModel(level: $0) }
    }
}

extension LevelListViewModel: LevelListDataProvider {
    var numberOfRows: Int {
        return levelDataModels.count
    }
    
    func displayModel(for index: Int) -> LevelDataModel {
        return levelDataModels[index]
    }
}

extension LevelListViewModel: LevelListActions {}
