//
//  StorageService.swift
//  Chatter
//
//  Created by Кирилл Медведев on 23.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import FirebaseAuth
import FirebaseStorage

class StorageService {
    static let shared = StorageService()
    
    let storageRef = Storage.storage().reference()
    
    private var currentUserId: String {
        return Auth.auth().currentUser!.uid
    }
    
    private var avatarsRef: StorageReference {
        return storageRef.child("avatars")
    }
    
    func uploadImage(photo: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
        guard let scaledImage = photo.scaledToSafeUploadSize, let imageData = scaledImage.jpegData(compressionQuality: 0.4) else { return }
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpeg"
        avatarsRef.child(currentUserId).putData(imageData, metadata: metaData) { (metadata, error) in
            guard let _ = metadata else { completion(.failure(error!)); return }
            self.avatarsRef.child(self.currentUserId).downloadURL { (url, error) in
                guard let downloadUrl = url else { completion(.failure(error!)); return }
                completion(.success(downloadUrl))
            }
        }
        
        
    }
}
