//
//  UIView+Extension.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 08/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

extension UIView {
    func round() {
        self.layer.cornerRadius = self.frame.size.height / 2
    }

    func round(with corner: CGFloat) {
        self.layer.cornerRadius = corner
    }
}
