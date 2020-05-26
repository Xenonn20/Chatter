//
//  WaitingChatCell.swift
//  Chatter
//
//  Created by Кирилл Медведев on 19.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import SDWebImage

class WaitingChatCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "WaitingChatCell"
    var friendImageView: UIImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstaints()
        layer.cornerRadius = 4
        clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configure<U>(with value: U) where U : Hashable {
        guard let value: MChat = value as? MChat else { return }
        guard let url = URL(string: value.friendAvatarString) else { return }
        friendImageView.sd_setImage(with: url, completed: nil)
    }
    
    private func setupConstaints() {
        addSubview(friendImageView)
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addConstraints([
            friendImageView.topAnchor.constraint(equalTo: topAnchor),
            friendImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            friendImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            friendImageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}
