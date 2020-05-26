//
//  ListenerService.swift
//  Chatter
//
//  Created by Кирилл Медведев on 23.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore

class ListenerService {
    
    static let shared = ListenerService()
    
    private let db = Firestore.firestore()
    
    private var usersRef: CollectionReference {
        return db.collection("users")
    }
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    func userObserve(users: [MUser], completion: @escaping (Result<[MUser], Error>) -> Void) -> ListenerRegistration {
        var users = users
        let usersListener = usersRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { completion(.failure(error!)); return }
            snapshot.documentChanges.forEach { (diff) in
                guard let muser = MUser(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !users.contains(muser) else { return }
                    guard muser.id != self.currentUserId else { return }
                    users.append(muser)
                case .modified:
                    guard let index = users.firstIndex(of: muser) else { return }
                    users[index] = muser
                case .removed:
                    guard let index = users.firstIndex(of: muser) else { return }
                    users.remove(at: index)
                }
            }
            completion(.success(users))
        }
        return usersListener
    }
    
    func waitingChatsObserve(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration {
        var chats = chats
        let chatsRef = db.collection(["users", currentUserId, "waitingChat"].joined(separator: "/"))
        let listener = chatsRef.addSnapshotListener { (snapshot, error) in
            guard let snapshot = snapshot else { completion(.failure(error!)); return }
            snapshot.documentChanges.forEach { (diff) in
                guard let chat = MChat(document: diff.document) else { return }
                switch diff.type {
                case .added:
                    guard !chats.contains(chat) else { return }
                    chats.append(chat)
                case .modified:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats[index] = chat
                case .removed:
                    guard let index = chats.firstIndex(of: chat) else { return }
                    chats.remove(at: index)
                }
            }
            completion(.success(chats))
        }
        return listener
    }
    
    func activeChatsObserve(chats: [MChat], completion: @escaping (Result<[MChat], Error>) -> Void) -> ListenerRegistration {
           var chats = chats
           let chatsRef = db.collection(["users", currentUserId, "activeChat"].joined(separator: "/"))
           let listener = chatsRef.addSnapshotListener { (snapshot, error) in
               guard let snapshot = snapshot else { completion(.failure(error!)); return }
               snapshot.documentChanges.forEach { (diff) in
                   guard let chat = MChat(document: diff.document) else { return }
                   switch diff.type {
                   case .added:
                       guard !chats.contains(chat) else { return }
                       chats.append(chat)
                   case .modified:
                       guard let index = chats.firstIndex(of: chat) else { return }
                       chats[index] = chat
                   case .removed:
                       guard let index = chats.firstIndex(of: chat) else { return }
                       chats.remove(at: index)
                   }
               }
               completion(.success(chats))
           }
           return listener
       }
}
