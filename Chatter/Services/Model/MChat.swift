//
//  MChat.swift
//  Chatter
//
//  Created by Кирилл Медведев on 19.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendAvatarSting: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUserName": friendUserName]
        rep["friendAvatarSting"] = friendAvatarSting
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
