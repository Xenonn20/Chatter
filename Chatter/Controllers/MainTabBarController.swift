//
//  MainTabBarController.swift
//  Chatter
//
//  Created by Кирилл Медведев on 18.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private let currentUser: MUser
    
    init(currentUser: MUser) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
    }
    // для SwiftUI
    init(fake: MUser = MUser(username: "1",
                             email: "2",
                             avatarStringURL: "3",
                             description: "4",
                             sex: "5",
                             id: "5")) {
        self.currentUser = fake
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let listVC = ListViewController(currentUser: currentUser)
        let peoplceVC = PeopleViewController(currentUser: currentUser)
        
        tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
        let boldConf = UIImage.SymbolConfiguration(weight: .medium)
        let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConf)!
        let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConf)!
        
        viewControllers = [
            generateNavigationController(rootViewController: peoplceVC, title: "People", image: peopleImage),
            generateNavigationController(rootViewController: listVC, title: "Conversation", image: convImage)
        ]
    }
    
    private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }
    
}
