//
//  ActiveChatCell.swift
//  Chatter
//
//  Created by Кирилл Медведев on 19.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import SDWebImage

class ActiveChatCell: UICollectionViewCell, SelfConfiguringCell {

    static var reuseId: String = "ActiveChatCell"
    
    var friendImageView: UIImageView = UIImageView()
    private let friendName = UILabel(text: "User Name", font: .laoSangamMN20())
    private let lastMessage = UILabel(text: "Bla Bla Bla", font: .laoSangamMN18())
    private let gradientView = GradientView(from: .topTrailing, to: .bottomLeading, startColor: #colorLiteral(red: 0.7882352941, green: 0.631372549, blue: 0.9411764706, alpha: 1), endColor: #colorLiteral(red: 0.4784313725, green: 0.6980392157, blue: 0.9215686275, alpha: 1))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupConstaints()
        
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure<U>(with value: U) where U : Hashable {
        guard let value: MChat = value as? MChat else { return }
        friendName.text = value.friendUserName
        lastMessage.text = value.lastMessageContent
        guard let url = URL(string: value.friendAvatarString) else { return }
        friendImageView.sd_setImage(with: url, completed: nil)
      }

    
    private func setupConstaints() {
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        friendName.translatesAutoresizingMaskIntoConstraints = false
        lastMessage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(friendImageView)
        addSubview(gradientView)
        addSubview(friendName)
        addSubview(lastMessage)
        
        
        addConstraints([
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            friendImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            friendImageView.heightAnchor.constraint(equalToConstant: 78),
            friendImageView.widthAnchor.constraint(equalToConstant: 78),
            
            gradientView.trailingAnchor.constraint(equalTo: trailingAnchor),
            gradientView.centerYAnchor.constraint(equalTo: centerYAnchor),
            gradientView.widthAnchor.constraint(equalToConstant: 8),
            gradientView.heightAnchor.constraint(equalToConstant: 78),
            
            friendName.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            friendName.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            friendName.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16),
            
            lastMessage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -14),
            lastMessage.leadingAnchor.constraint(equalTo: friendImageView.trailingAnchor, constant: 16),
            lastMessage.trailingAnchor.constraint(equalTo: gradientView.leadingAnchor, constant: -16)
        ])
    }
}
