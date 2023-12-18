//
//  RegistrationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 07/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let registrationView = RegistrationView()
    var registrationViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigation()
        addView()
        addTargets()
        addDelegates()
    }

    func addNavigation() {
        self.navigationItem.title = "Registration"
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    
    func addView() {
        view.addSubview(registrationView)
        registrationView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        registrationView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    func addDelegates() {
        registrationView.scrollView.delegate = self
        registrationView.emailTextField.delegate = self
        registrationView.usernameTextField.delegate = self
        registrationView.passwordTextField.delegate = self
        registrationView.repeatPasswordTextField.delegate = self
    }
    
    @objc func backButtonPressed() {
//        dismiss(animated: true)
//        navigationController?.popViewController(animated: true)
        
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func nextButtonPressed() {

        guard let email = registrationView.emailTextField.text,
              let username = registrationView.usernameTextField.text,
              let password = registrationView.passwordTextField.text
        else {
            return
        }
        registrationViewModel.register(email: email, username: username, password: password)
        
        let vc = WelcomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}


// MARK: - UIScrollViewDelegate
extension RegistrationViewController: UIScrollViewDelegate {
    
}


// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
    
}
