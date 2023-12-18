//
//  LoginViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    let loginView = LoginView()
    var loginViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTargets()
        addDelegates()
    }
    
    func addView(){
        view.addSubview(loginView)
        loginView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addDelegates() {
        loginView.usernameTextField.delegate = self
        loginView.passwordTextField.delegate = self
    }
    
    func addTargets() {
        loginView.loginButton.addTarget(self, action: #selector(loginButtonPressed), for: .touchUpInside)
        loginView.createButton.addTarget(self, action: #selector(createButtonPressed), for: .touchUpInside)
    }
    
    @objc func loginButtonPressed() {
        guard let username = loginView.usernameTextField.text,
              let password = loginView.passwordTextField.text else {
            // Show alert label to user
            loginView.alertLabel.isHidden = false
            print("Invalid input. Please fill in all fields.")
            return
        }
        loginViewModel.login(username: username, password: password)
        
        let vc = WelcomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func createButtonPressed() {
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
}

