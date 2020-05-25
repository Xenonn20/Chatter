//
//  ProfileViewController.swift
//  Chatter
//
//  Created by Кирилл Медведев on 20.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import SDWebImage
class ProfileViewController: UIViewController {
    
    private let conteinerView = UIView()
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "human5"), contentMode: .scaleAspectFill)
    private let nameLabel = UILabel(text: "Tom Holland", font: .systemFont(ofSize: 20, weight: .light))
    private let aboutLabel = UILabel(text: "You have the opportunity to chat with the me!", font: .systemFont(ofSize: 16, weight: .light))
    private let myTextField = InsertableTextField()
    
    private var user: MUser
    
    init(user: MUser) {
        self.user = user
        self.nameLabel.text = user.username
        self.aboutLabel.text = user.description
        let url = URL(string: user.avatarStringURL)
        self.imageView.sd_setImage(with: url, completed: nil)
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstaints()
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        myTextField.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        
        aboutLabel.numberOfLines = 0
        conteinerView.backgroundColor = .mainWhite()
        conteinerView.layer.cornerRadius = 30
        
        if let button = myTextField.rightView as? UIButton {
            button.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        }
    }
    
    @objc
    private func sendMessage() {
        guard let message = myTextField.text, message != "" else { return }
        self.dismiss(animated: true) {
            FirestoreService.shared.createWaitingChat(message: message, receiver: self.user) { (result) in
                switch result {
                case .success():
                    UIApplication.getTopViewController()?.showAlert(with: "Успешно", and: "Ваше сообщение отправлено")
                case .failure(let error):
                    UIApplication.getTopViewController()?.showAlert(with: "Error", and: error.localizedDescription)
                }
            }
            
        }
        
    }
    
}

extension ProfileViewController {
    private func setupConstaints() {
        view.addSubview(imageView)
        view.addSubview(conteinerView)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(aboutLabel)
        conteinerView.addSubview(myTextField)
        
        view.addConstraints([
            conteinerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            conteinerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            conteinerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            conteinerView.heightAnchor.constraint(equalToConstant: 206),
            
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 30),
        ])
        
        conteinerView.addConstraints([
            nameLabel.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 35),
            nameLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            
            aboutLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
            aboutLabel.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            aboutLabel.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            
            myTextField.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 8),
            myTextField.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            myTextField.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            myTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
    }
}
