//
//  SelfConfiguringCell.swift
//  Chatter
//
//  Created by Кирилл Медведев on 19.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit


protocol SelfConfiguringCell: class {
    static var reuseId: String { get }
     var friendImageView: UIImageView { get }
    func configure<U: Hashable>(with value: U)
}
