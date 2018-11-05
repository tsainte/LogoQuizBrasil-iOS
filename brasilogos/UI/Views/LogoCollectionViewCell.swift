//
//  LogoCollectionViewCell.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LogoCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var innerView: UIView!
    @IBOutlet weak var logoImage: UIImageView!

    func configure(_ displayModel: LogoCellDisplayModel) {
        outerView.layer.cornerRadius = 6
        innerView.layer.cornerRadius = 6

        logoImage.image = UIImage(named: displayModel.image)
    }
}
