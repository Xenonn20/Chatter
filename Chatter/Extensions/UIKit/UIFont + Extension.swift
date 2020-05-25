//
//  UIFont + Extension.swift
//  Chatter
//
//  Created by Кирилл Медведев on 17.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    static func avenir20() -> UIFont {
        return UIFont.init(name: "avenir", size: 20)!
    }
    
    static func avenir26() -> UIFont {
        return UIFont.init(name: "avenir", size: 26)!
    }
    
    static func laoSangamMN20() -> UIFont? {
        return UIFont.init(name: "Lao Sangam MN", size: 20)
    }
    
    static func laoSangamMN18() -> UIFont? {
        return UIFont.init(name: "Lao Sangam MN", size: 18)
    }
}