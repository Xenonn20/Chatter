//
//  MMessage.swift
//  Chatter
//
//  Created by Кирилл Медведев on 23.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import FirebaseFirestore
import MessageKit

struct UserFix: SenderType, Equatable {
    var senderId: String
    var displayName: String
    
    init(senderId: String, displayName: String) {
        self.senderId = senderId
        self.displayName = displayName
    }
    static func == (lhs: UserFix, rhs: UserFix) -> Bool {
        return lhs.senderId == rhs.senderId
    }
}

struct MMessage: Hashable, MessageType {

    let content: String
    var sender: SenderType
    var sentDate: Date
    var kind: MessageKind {
        return .text(content)
    }

    let id: String?
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    init(user: MUser, content: String) {
        self.content = content
        self.sender = user
        self.sentDate = Date()
        self.id = nil
    }
    
    init?(documents: QueryDocumentSnapshot) {
        let data = documents.data()
        guard let sentDate = data["created"] as? Timestamp else { return nil}
        guard let senderId = data["senderID"] as? String else { return nil}
        guard let senderUsername = data["senderName"] as? String else { return nil}
        guard let content = data["content"] as? String else { return nil}
        
        self.id = documents.documentID
        self.sentDate = sentDate.dateValue()
        self.sender = UserFix(senderId: senderId, displayName: senderUsername)
        self.content = content
    }
    var representation: [String: Any] {
        let rep: [String: Any] = [
            "created": sentDate,
            "senderID": sender.senderId,
            "senderName": sender.displayName,
            "content": content
        ]
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
           hasher.combine(messageId)
       }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.messageId == rhs.messageId
    }
}

extension MMessage: Comparable {
    static func < (lhs: MMessage, rhs: MMessage) -> Bool {
        return lhs.sentDate < rhs.sentDate
    }
    
    
}

