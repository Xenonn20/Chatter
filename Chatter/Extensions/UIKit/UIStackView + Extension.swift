//
//  UIStackView + Extension.swift
//  Chatter
//
//  Created by Кирилл Медведев on 17.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat) {
        self.init(arrangedSubviews: arrangedSubviews)
        
        self.axis = axis
        self.spacing = spacing
    }
}
