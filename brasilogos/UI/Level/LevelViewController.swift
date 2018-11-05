//
//  LevelViewController.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LevelViewController: UIViewController {

    var viewModel: LevelViewModelType!
    var collectionViewManager: LevelCollectionViewManager!
    @IBOutlet weak var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionViewManager = LevelCollectionViewManager(collectionView: collectionView,
                                                     dataProvider: viewModel as LevelDataProvider,
                                                     actions: viewModel as LevelActions)
    }
}

extension LevelViewController: LevelViewModelDelegate {

}

