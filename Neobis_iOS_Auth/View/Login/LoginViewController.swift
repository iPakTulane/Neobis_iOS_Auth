//
//  LoginViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    lazy var loginView = LoginView()
    lazy var loginViewModel = AuthViewModel()
    
    override func loadView() {
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Hides back button
        navigationItem.hidesBackButton = true
        addTargets()
        addDelegates()
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
        
        // Move logic to AuthViewModel
        loginViewModel.login(username: username, password: password) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    // Handle the successful login
                    let vc = WelcomeViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self?.present(vc, animated: true, completion: nil)
                    
                case .failure(let error):
                    // Handle the login failure
                    print("Login failure: \(error)")
                    // You may want to update UI elements or show an alert to the user
                }
            }
        }
    }
        
    
    @objc func createButtonPressed() {
        let vc = RegistrationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
}
