//
//  WaitingChatsNavigation.swift
//  Chatter
//
//  Created by Кирилл Медведев on 26.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation

protocol WaitingChatsNavigation: class {
    func removeWaitingChat(chat: MChat)
    func chatToActive(chat: MChat)
}
