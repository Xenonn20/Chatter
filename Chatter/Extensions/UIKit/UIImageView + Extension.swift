//
//  UIImageView + Extension.swift
//  Chatter
//
//  Created by Кирилл Медведев on 17.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

extension UIImageView {
    
    convenience init(image: UIImage?, contentMode: UIView.ContentMode ) {
        self.init()
        
        self.image = image
        self.contentMode = contentMode
    }
}

extension UIImageView {
    func setupColor(color: UIColor) {
        let templateImage = self.image?.withRenderingMode(.alwaysTemplate)
        self.image = templateImage
        self.tintColor = color
    }
}

