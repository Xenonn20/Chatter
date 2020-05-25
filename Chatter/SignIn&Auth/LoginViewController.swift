//
//  LoginViewController.swift
//  Chatter
//
//  Created by Кирилл Медведев on 18.05.2020.
//  Copyright © 2020 Kirill Medvedev. All rights reserved.
//

import FirebaseAuth
import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    private let welcomeLabel = UILabel(text: "Welcome back!", font: .avenir26())
    private let loginWithLabel = UILabel(text: "Login with")
    private let orLabel = UILabel(text: "or")
    private let emailLabel = UILabel(text: "Email")
    private let passwordLabel = UILabel(text: "Password")
    private let accountLabel = UILabel(text: "Need an account?")
    
    private let googleButton = UIButton(title: "Google", titleColor: .black, backgroundColor: .white, isShadow: true)
    private let emailTextField = OnLineTextField(font: .avenir20())
    private let passwordTextField = OnLineTextField(font: .avenir20())
    private let loginButton = UIButton(title: "Login", titleColor: .white, backgroundColor: .buttonBlack())
    
    private let signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(.buttonRed(), for: .normal)
        button.titleLabel?.font = .avenir20()
        button.contentHorizontalAlignment = .leading
        
        return button
    }()
    weak var delegate: AuthNavigationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        googleButton.customizeGoogleButton()
        setupConstaints()
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func loginButtonTapped() {
        AuthService.shared.login(email: emailTextField.text!, password: passwordTextField.text!) { (result) in
            switch result {
            case .success(let user):
                self.showAlert(with: "Успешно", and: "Вы авторизовались!") {
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let muser):
                            let mainTabBar = MainTabBarController(currentUser: muser)
                            mainTabBar.modalPresentationStyle = .fullScreen
                            self.present(mainTabBar, animated: true, completion: nil)
                        case .failure(let error):
                            self.present(SetupProfileViewController(currentUser: user), animated: true, completion: nil)
                        }
                    }
                    
                }
            case .failure(let error):
                self.showAlert(with: "Ошибка", and: error.localizedDescription)
            }
        }
    }
    
    @objc
    private func signUpButtonTapped() {
        dismiss(animated: true) {
            self.delegate?.toSignUp()
        }
    }
    
    @objc
    private func googleButtonTapped() {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
}

// MARK: - Layout

extension LoginViewController {
    private func setupConstaints() {
        let loginWithView = ButtonFormView(label: loginWithLabel, button: googleButton)
        let emailStackView = UIStackView(arrangedSubviews: [emailLabel, emailTextField], axis: .vertical, spacing: 0)
        let passwordStackView = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField], axis: .vertical, spacing: 0)
        loginButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        let stackView = UIStackView(arrangedSubviews: [loginWithView,
                                                       orLabel,
                                                       emailStackView,
                                                       passwordStackView,
                                                       loginButton]
            , axis: .vertical, spacing: 30)
        
        let bottomStackView = UIStackView(arrangedSubviews: [accountLabel, signUpButton], axis: .horizontal, spacing: 10)
        bottomStackView.alignment = .firstBaseline
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(welcomeLabel)
        view.addSubview(stackView)
        view.addSubview(bottomStackView)
        
        view.addConstraints([
            welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            welcomeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            stackView.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            bottomStackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
        ])
    }
}


import SwiftUI

struct LoginControllerProvider: PreviewProvider {
    static var previews: some View {
        ContainerView()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct ContainerView: UIViewControllerRepresentable {
        
        let viewController = LoginViewController()
        
        func makeUIViewController(context: UIViewControllerRepresentableContext<LoginControllerProvider.ContainerView>) -> LoginViewController {
            return viewController
        }
        func updateUIViewController(_ uiViewController: LoginControllerProvider.ContainerView.UIViewControllerType, context: UIViewControllerRepresentableContext<LoginControllerProvider.ContainerView>) {
            
        }
    }
}
