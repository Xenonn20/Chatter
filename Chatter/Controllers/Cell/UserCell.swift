//
//  UserCell.swift
//  Chatter
//
//  Created by Кирилл Медведев on 20.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import SDWebImage

class UserCell: UICollectionViewCell, SelfConfiguringCell {
    
    
    static var reuseId: String = "UserCell"
    var friendImageView: UIImageView = UIImageView()
    private let userName: UILabel = UILabel(text: "User Name", font: .laoSangamMN20())
    private let containerView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstaints()
        
        layer.shadowColor = #colorLiteral(red: 0.7411764706, green: 0.7411764706, blue: 0.7411764706, alpha: 1)
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 4)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        friendImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        containerView.layer.cornerRadius = 4
        containerView.clipsToBounds = true
    }
    
    private func setupConstaints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        userName.translatesAutoresizingMaskIntoConstraints = false
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(containerView)
        containerView.addSubview(userName)
        containerView.addSubview(friendImageView)
        
        addConstraints([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            friendImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            friendImageView.heightAnchor.constraint(equalTo: containerView.widthAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            
            userName.topAnchor.constraint(equalTo: friendImageView.bottomAnchor),
            userName.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            userName.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            userName.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
        ])
        
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let user: MUser = value as? MUser else { return }
        guard let url = URL(string: user.avatarStringURL) else { return }
        friendImageView.sd_setImage(with: url, completed: nil)
        userName.text = user.username
    }  
}
