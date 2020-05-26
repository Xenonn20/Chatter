//
//  MChat.swift
//  Chatter
//
//  Created by Кирилл Медведев on 19.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct MChat: Hashable, Decodable {
    var friendUserName: String
    var friendAvatarString: String
    var lastMessageContent: String
    var friendId: String
    
    var representation: [String: Any] {
        var rep = ["friendUserName": friendUserName]
        rep["friendAvatarString"] = friendAvatarString
        rep["lastMessage"] = lastMessageContent
        rep["friendId"] = friendId
        return rep
    }
    
    init(friendUserName: String, friendAvatarString: String, lastMessageContent: String, friendId: String) {
        self.friendUserName = friendUserName
        self.friendAvatarString = friendAvatarString
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let friendUserName =  data["friendUserName"] as? String,
            let friendAvatarSrting =  data["friendAvatarString"] as? String,
            let lastMessageContent =  data["lastMessage"] as? String,
            let friendId =  data["friendId"] as? String else { return nil }
        
        self.friendUserName = friendUserName
        self.friendAvatarString = friendAvatarSrting
        self.lastMessageContent = lastMessageContent
        self.friendId = friendId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(friendId)
    }
    static func == (lhs: MChat, rhs: MChat) -> Bool {
        return lhs.friendId == rhs.friendId
    }
}
