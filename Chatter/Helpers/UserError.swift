//
//  UserError.swift
//  Chatter
//
//  Created by Кирилл Медведев on 22.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case canNotGetUserInfo
    case cannotUnwrapToMuser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Пользователь не выбрал фотографию", comment: "")
        case .canNotGetUserInfo:
            return NSLocalizedString("Невозможно загрузить информацию по юзеру", comment: "")
        case .cannotUnwrapToMuser:
            return NSLocalizedString("Невозможно конвертировать модель", comment: "")
        }
    }
}
