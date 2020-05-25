//
//  AuthNavigationDelegate.swift
//  Chatter
//
//  Created by Кирилл Медведев on 22.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation

protocol AuthNavigationDelegate: class {
    func toLoginVC()
    func toSignUp()
}
