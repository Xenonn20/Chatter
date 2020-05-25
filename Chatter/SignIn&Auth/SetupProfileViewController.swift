//
//  SetupProfileViewController.swift
//  Chatter
//
//  Created by Кирилл Медведев on 18.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//
import UIKit
import FirebaseAuth
import SDWebImage


class SetupProfileViewController: UIViewController {
    
    private let fullImageView = AddPhotoView()
    
    private let welcomeLabel = UILabel(text: "Set up Profile", font: .avenir26())
    private let fullNameLabel = UILabel(text: "Full name")
    private let aboutLabel = UILabel(text: "Abot me")
    private let sexLabel = UILabel(text: "Sex")
    
    private let fullNameTextField = OnLineTextField(font: .avenir20())
    private let aboutMeTextField = OnLineTextField(font: .avenir20())
    private let sexSegmentedControl = UISegmentedControl(first: "Male", second: "Female")
    
    private let goToChatsButton = UIButton(title: "Go to chats!", titleColor: .white, backgroundColor: .buttonBlack())
    
    private let currentUser: User
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(nibName: nil, bundle: nil)
        
        if let username = currentUser.displayName {
            fullNameTextField.text = username
        }
        if let photoUrl = currentUser.photoURL {
            fullImageView.circleView.sd_setImage(with: photoUrl, completed: nil)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupConstaints()
        
        goToChatsButton.addTarget(self, action: #selector(goToChatsButtonTaped), for: .touchUpInside)
        fullImageView.plusButton.addTarget(self, action: #selector(plusButtonTaped), for: .touchUpInside)
    }
    
    @objc
    private func plusButtonTaped() {
        let imgaePickerController = UIImagePickerController()
        imgaePickerController.delegate = self
        imgaePickerController.sourceType = .photoLibrary
        present(imgaePickerController, animated: true, completion: nil)
    }
    
    @objc
    private func goToChatsButtonTaped() {
        FirestoreService.shared.saveProfileWith(
            id: currentUser.uid,
            email: currentUser.email!,
            username: fullNameTextField.text,
            avatarImage: fullImageView.circleView.image,
            description: aboutLabel.text,
            sex: sexSegmentedControl.titleForSegment(at: sexSegmentedControl.selectedSegmentIndex)!) { (result) in
                switch result {
                case .success(let muser):
                    self.showAlert(with: "Успешно", and: "Приятного общения") {
                        let mainTabBar = MainTabBarController(currentUser: muser)
                        mainTabBar.modalPresentationStyle = .fullScreen
                        self.present(mainTabBar, animated: true, completion: nil)
                    }
                case .failure(let error):
                    self.showAlert(with: "Ошибка", and: error.localizedDescription)
                }
        }
    }
}

// MARK: - Layout
extension SetupProfileViewController {
    private func setupConstaints() {
        let fullNameStackView = UIStackView(arrangedSubviews: [fullNameLabel, fullNameTextField], axis: .vertical, spacing: 0)
        let aboutMetackView = UIStackView(arrangedSubviews: [aboutLabel, aboutMeTextField], axis: .vertical, spacing: 0)
        let sexStackView = UIStackView(arrangedSubviews: [sexLabel, sexSegmentedControl], axis: .vertical, spacing: 12)
        goToChatsButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        let stackView = UIStackView(arrangedSubviews: [fullNameStackView, aboutMetackView, sexStackView, goToChatsButton], axis: .vertical, spacing: 40)
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        fullImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(fullImageView)
        view.addSubview(stackView)
        view.addSubview(welcomeLabel)
        
        view.addConstraints([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            fullImageView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 40),
            fullImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: fullImageView.bottomAnchor, constant: 40),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
        ])
    }
}

// MARK: - UIImagePickerControllerDelegate

extension SetupProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        fullImageView.circleView.image = image
    }
}



import SwiftUI

struct SetupProfileControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = SetupProfileViewController(currentUser: Auth.auth().currentUser!)
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<SetupProfileControllerProvider.ContainerView>) -> SetupProfileViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: SetupProfileControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<SetupProfileControllerProvider.ContainerView>) {
        }
    }
}
