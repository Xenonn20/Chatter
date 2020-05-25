//
//  AuthService.swift
//  Chatter
//
//  Created by Кирилл Медведев on 21.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import Firebase
import FirebaseAuth
import FirebaseFirestore
import GoogleSignIn
import UIKit

class AuthService {
    
    static let shared = AuthService()
    private let auth = Auth.auth()
    
    func login(email: String?, password: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard let email = email, let password = password else { completion(.failure(AuthError.notFilled)); return }
        auth.signIn(withEmail: email, password: password) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
        
    }
    
    func googleLogin(user: GIDGoogleUser!, error: Error!, completion: @escaping (Result<User, Error>) -> Void) {
        if let error = error {
            completion(.failure(error))
            return
        }
        guard let auth = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credential) { (result, error) in
            guard let result = result else {completion(.failure(error!));return }
            completion(.success(result.user))
        }
    }
    
    func register(email: String?, password: String?, confirmPassword: String?, completion: @escaping (Result<User, Error>) -> Void) {
        guard Validators.isFilled(email: email, password: password, confirmPassword: confirmPassword)
            else { completion(.failure(AuthError.notFilled)); return }
        guard password!.lowercased() == confirmPassword!.lowercased() else { completion(.failure(AuthError.passwordNotMatched)); return }
        
        guard Validators.isSimpleEmail(email!) else { completion(.failure(AuthError.invalideEmail)); return }
        
        auth.createUser(withEmail: email!, password: password!) { (result, error) in
            guard let result = result else {
                completion(.failure(error!))
                return
            }
            completion(.success(result.user))
        }
    }
}
