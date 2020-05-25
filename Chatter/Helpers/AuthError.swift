//
//  AuthError.swift
//  Chatter
//
//  Created by Кирилл Медведев on 22.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation

enum AuthError {
    case notFilled
    case invalideEmail
    case passwordNotMatched
    case unknownError
    case serverError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalideEmail:
            return NSLocalizedString("Неверный формат Email", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        }
    }
}
