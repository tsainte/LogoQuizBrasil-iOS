//
//  LevelTableViewCell.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 05/11/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

class LevelTableViewCell: UITableViewCell {

    @IBOutlet weak var levelName: UILabel!
    @IBOutlet weak var levelProgress: UIProgressView!
    @IBOutlet weak var levelScore: UILabel!
    @IBOutlet weak var levelLocker: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure(with displayModel: LevelCellDisplayModel) {
        levelName.text = displayModel.levelName
        levelProgress.progress = displayModel.correctLogosPercentage
        levelScore.text = displayModel.correctLogosDescription

        levelProgress.isHidden = !displayModel.isEnabled
        levelScore.isHidden = !displayModel.isEnabled
        levelLocker.isHidden = displayModel.isEnabled
    }
}
