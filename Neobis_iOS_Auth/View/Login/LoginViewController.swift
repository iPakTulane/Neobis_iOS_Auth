//
//  LoginViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let contentView = LoginView()
    var userViewModel: UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.loginDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTargets()
        addDelegates()
    }
    
    
    func addView(){
        view.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addDelegates() {
        contentView.usernameTextField.delegate = self
        contentView.passwordTextField.delegate = self
    }
    
    func addTargets() {
        contentView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        contentView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        guard let username = contentView.usernameTextField.text,
              let password = contentView.passwordTextField.text else {
            // Show alert label to user
            contentView.alertLabel.isHidden = false
            return
        }
        userViewModel.loginUser(username: username, password: password)
        
        let vc = WelcomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func createButtonPressed() {
        let viewController = RegistrationViewController(userViewModel: userViewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
}

// MARK: - LoginViewModelDelegate
extension LoginViewController: LoginViewModelDelegate {

    func didLogin(user: TokenObtainPair) {
        print("Successfully logged in as \(user)")
    }
    
    func didFail(with error: Error) {
        print("Failed to login: \(error)")
    }
}
