//
//  MMessage.swift
//  Chatter
//
//  Created by Кирилл Медведев on 23.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

struct MMessage: Hashable {
    let content: String
    let senderId: String
    let senderUsername: String
    let sendDate: Date
    let id: String?
    
    init(user: MUser, content: String) {
        self.content = content
        self.senderId = user.id
        self.senderUsername = user.username
        self.sendDate = Date()
        self.id = nil
    }
    var representation: [String: Any] {
        var rep: [String: Any] = [
            "created": sendDate,
            "senderID": senderId,
            "senderName": sendDate,
            "content": content
        ]
        return rep
    }
}


