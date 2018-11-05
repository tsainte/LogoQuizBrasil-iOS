//
//  LevelViewModel.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import Foundation

struct LogoCellDisplayModel {
    let image: String
    let isSolved: Bool

    init(with logo: Logo) {
        image = logo.answerImageName
        isSolved = true
    }
}

protocol LevelViewModelDelegate: class {

}

typealias LevelViewModelType = LevelDataProvider & LevelActions

protocol LevelDataProvider {
    var numberOfItems: Int { get }
    func displayModel(for index: Int) -> LogoCellDisplayModel
}

protocol LevelActions {

}

class LevelViewModel {

    weak var viewDelegate: LevelViewModelDelegate?
    let coordinator: LevelCoordinatorDelegate
    let level: Level
    let logoCellDisplayModels: [LogoCellDisplayModel]

    init(delegate: LevelViewModelDelegate, coordinator: LevelCoordinatorDelegate, level: Level) {
        self.viewDelegate = delegate
        self.coordinator = coordinator
        self.level = level

        logoCellDisplayModels = level.logos.map { LogoCellDisplayModel(with: $0) }
    }
}

extension LevelViewModel: LevelDataProvider {
    var numberOfItems: Int {
        return level.logos.count
    }

    func displayModel(for index: Int) -> LogoCellDisplayModel {
        return logoCellDisplayModels[index]
    }
}

extension LevelViewModel: LevelActions {

}
