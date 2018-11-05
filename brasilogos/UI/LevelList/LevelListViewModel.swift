//
//  LevelListViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 14/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LevelCellDisplayModel {
    let levelName: String
    let correctLogosDescription: String
    let correctLogosPercentage: Float
    let isEnabled: Bool

    init(level: Level) {
        let correctLogos = BLDatabaseManager.correctLogos(forLevel: level.levelNumber)
        let totalLogos = LogoParser.logosPerLevel

        levelName = "Nível \(level.levelNumber)"
        correctLogosDescription = "\(correctLogos) / \(totalLogos)"
        correctLogosPercentage = Float(correctLogos / totalLogos)
        isEnabled = BLGameManager.canPlayLevel(level.levelNumber)
    }
}

typealias LevelListViewModelType = LevelListDataProvider & LevelListActions

protocol LevelListDataProvider {
    var numberOfRows: Int { get }
    func displayModel(for index: Int) -> LevelCellDisplayModel
}

protocol LevelListActions {
    func userDidTapped(index: Int)
}

protocol LevelListViewModelDelegate: class {
    func showMessage(_ message: String)
}

class LevelListViewModel: ViewModel {

    weak var viewDelegate: LevelListViewModelDelegate?
    let levelCellDisplayModels: [LevelCellDisplayModel]
    let coordinator: LevelListCoordinatorDelegate

    init(delegate: LevelListViewModelDelegate,
         coordinator: LevelListCoordinatorDelegate,
         levels: [Level]) {
        self.viewDelegate = delegate
        self.coordinator = coordinator
        levelCellDisplayModels = levels.map { LevelCellDisplayModel(level: $0) }
    }
}

extension LevelListViewModel: LevelListDataProvider {
    var numberOfRows: Int {
        return levelCellDisplayModels.count
    }

    func displayModel(for index: Int) -> LevelCellDisplayModel {
        return levelCellDisplayModels[index]
    }
}

extension LevelListViewModel: LevelListActions {
    func userDidTapped(index: Int) {
        let level = index + 1
        let levelEnabled = BLGameManager.canPlayLevel(level)

        if levelEnabled {
            coordinator.goToLevel(level)
        } else {
            viewDelegate?.showMessage("oops")
        }
    }
}
