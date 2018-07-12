//
//  CustomUIButton.swift
//  brasilogos
//
//  Created by Tiago Bencardino on 10/07/2018.
//  Copyright © 2018 MobWiz. All rights reserved.
//

import UIKit

@IBDesignable
class CustomUIButton: UIButton {

    @IBInspectable
    var cornerRadius: CGFloat = 0.0 {
        didSet {
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable
    var rounded: Bool = false {
        didSet {
            self.layer.cornerRadius = self.frame.size.height / 2
        }
    }
}
