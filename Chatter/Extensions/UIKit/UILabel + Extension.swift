//
//  UILabel + Extension.swift
//  Chatter
//
//  Created by Кирилл Медведев on 17.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont? = .avenir20()) {
        self.init()
        
        self.text = text
        self.font = font
    }
}
