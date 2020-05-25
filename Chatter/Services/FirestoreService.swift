//
//  FirestoreService.swift
//  Chatter
//
//  Created by Кирилл Медведев on 22.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirestoreService {
    static let shared = FirestoreService()
    let db = Firestore.firestore()
    
    private var userRef: CollectionReference {
        return db.collection("users")
    }
    
    var currentUser: MUser!
    
    func getUserData(user: User, completion: @escaping (Result<MUser, Error>) -> Void) {
        let docRef = userRef.document(user.uid)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                guard let muser = MUser(document: document) else { completion(.failure(UserError.cannotUnwrapToMuser)); return }
                self.currentUser = muser
                completion(.success(muser))
            } else {
                completion(.failure(UserError.canNotGetUserInfo))
            }
        }
    }
    
    func saveProfileWith(id: String, email: String, username: String?, avatarImage: UIImage?, description: String?, sex: String, completion: @escaping (Result<MUser, Error>) -> Void) {
        guard Validators.isFilled(username: username, description: description, sex: sex) else { completion(.failure(UserError.notFilled)); return }
        guard avatarImage != #imageLiteral(resourceName: "avatar") else {completion(.failure(UserError.photoNotExist)); return }
        var muser = MUser(username: username!, email: email, avatarStringURL: "not", description: description!, sex: sex, id: id)
        StorageService.shared.uploadImage(photo: avatarImage!) { (result) in
            switch result {
            case .success(let url):
                muser.avatarStringURL = url.absoluteString
                self.userRef.document(muser.id).setData(muser.representation) { (error) in
                    if let error = error {
                        completion(.failure(error))
                    } else {
                        completion(.success(muser))
                    }
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func createWaitingChat(message: String, receiver: MUser, completion: @escaping (Result<Void, Error>) -> Void) {
        let reference = db.collection(["users", receiver.id, "waitingChats"].joined(separator: "/"))
        let messageRef = reference.document(self.currentUser.id).collection("messages")
        
        let message = MMessage(user: currentUser, content: message)
        let chat = MChat(friendUserName: currentUser.username,
                         friendAvatarSting: currentUser.avatarStringURL,
                         lastMessageContent: message.content,
                         friendId: currentUser.id)
        reference.document(currentUser.id).setData(chat.representation) { (error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            messageRef.document(self.currentUser.id).setData(message.representation) { (error) in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                completion(.success(Void()))
            }
        }
    }
}
