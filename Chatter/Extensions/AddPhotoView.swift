//
//  AddPhotoView.swift
//  Chatter
//
//  Created by Кирилл Медведев on 18.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit
import SDWebImage

class AddPhotoView: UIView {
    
     let circleView: UIImageView = {
       let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "avatar")
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.borderWidth = 1
        
        return image
    }()
    
     let plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        let image = #imageLiteral(resourceName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .buttonBlack()
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupConstraints()
    }
    
    override func layoutSubviews() {
          super.layoutSubviews()
          circleView.layer.masksToBounds = true
          circleView.layer.cornerRadius = circleView.frame.width / 2
      }
    
    private func setupConstraints() {
        addSubview(circleView)
        addSubview(plusButton)
        
        addConstraints([
            circleView.topAnchor.constraint(equalTo: topAnchor),
            circleView.leadingAnchor.constraint(equalTo: leadingAnchor),
            circleView.widthAnchor.constraint(equalToConstant: 100),
            circleView.heightAnchor.constraint(equalToConstant: 100),
            
            plusButton.leadingAnchor.constraint(equalTo: circleView.trailingAnchor, constant: 16),
            plusButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusButton.widthAnchor.constraint(equalToConstant: 30),
            plusButton.heightAnchor.constraint(equalToConstant: 30),
            
            bottomAnchor.constraint(equalTo: circleView.bottomAnchor),
            trailingAnchor.constraint(equalTo: plusButton.trailingAnchor)
        ])
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
