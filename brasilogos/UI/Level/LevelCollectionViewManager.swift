//
//  LevelCollectionViewManager.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit
class LevelCollectionViewManager: NSObject {

    let collectionView: UICollectionView
    var dataProvider: LevelDataProvider
    var actions: LevelActions

    init(collectionView: UICollectionView, dataProvider: LevelDataProvider, actions: LevelActions) {
        self.collectionView = collectionView
        self.dataProvider = dataProvider
        self.actions = actions
        super.init()

        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension LevelCollectionViewManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataProvider.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LogoCollectionViewCell",
                                                            for: indexPath)
            as? LogoCollectionViewCell else {
                fatalError("Can't dequeue LogoCollectionViewCell")
        }
        let displayModel = dataProvider.displayModel(for: indexPath.row)
        cell.configure(displayModel)

        return cell
    }
}

extension LevelCollectionViewManager: UICollectionViewDelegate {
}
