//
//  ChatRequestViewController.swift
//  Chatter
//
//  Created by Кирилл Медведев on 20.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

class ChatRequestViewController: UIViewController {
    
    private let conteinerView = UIView()
    private let imageView = UIImageView(image: #imageLiteral(resourceName: "human5"), contentMode: .scaleAspectFill)
    private let nameLabel = UILabel(text: "Tom Holland", font: .systemFont(ofSize: 20, weight: .light))
    private let aboutLabel = UILabel(text: "You have the opportunity to chat a new chat!", font: .systemFont(ofSize: 16, weight: .light))
    private let acceptButton = UIButton(title: "ACCEPT", titleColor: .white, backgroundColor: .black, font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
    private let denyButton = UIButton(title: "Deny", titleColor: #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1), backgroundColor: .mainWhite(), font: .laoSangamMN20(), isShadow: false, cornerRadius: 10)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstaints()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        acceptButton.applyGradients(cornerRadius: 10)
    }
    
    private func setupUI() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        aboutLabel.translatesAutoresizingMaskIntoConstraints = false
        
        conteinerView.backgroundColor = .mainWhite()
        conteinerView.layer.cornerRadius = 30
        
        denyButton.layer.borderWidth = 1.2
        denyButton.layer.borderColor = #colorLiteral(red: 0.8352941176, green: 0.2, blue: 0.2, alpha: 1)
    }
}

extension ChatRequestViewController {
    private func setupConstaints() {
        view.addSubview(imageView)
        view.addSubview(conteinerView)
        conteinerView.addSubview(nameLabel)
        conteinerView.addSubview(aboutLabel)
        let buttonsStackView = UIStackView(arrangedSubviews: [acceptButton, denyButton], axis: .horizontal, spacing: 7)
        buttonsStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonsStackView.distribution = .fillEqually
        conteinerView.addSubview(buttonsStackView)
        
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
            
            buttonsStackView.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 24),
            buttonsStackView.leadingAnchor.constraint(equalTo: conteinerView.leadingAnchor, constant: 24),
            buttonsStackView.trailingAnchor.constraint(equalTo: conteinerView.trailingAnchor, constant: -24),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
