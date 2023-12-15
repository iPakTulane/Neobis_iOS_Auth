//
//  RegistrationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 07/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    let contentView = RegistrationView()
    var userViewModel: UserViewModelProtocol!
    
    init(userViewModel: UserViewModelProtocol) {
        super.init(nibName: nil, bundle: nil)
        self.userViewModel = userViewModel
        self.userViewModel.registrationDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigation()
        addView()
        addTargets()
        addDelegates()
    }

    func addNavigation() {
        title = "Registration"
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    
    func addView() {
        view.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
    }
    
    func addDelegates() {
        contentView.scrollView.delegate = self
        contentView.emailTextField.delegate = self
        contentView.usernameTextField.delegate = self
        contentView.passwordTextField.delegate = self
        contentView.repeatPasswordTextField.delegate = self
    }
    
    @objc func backButtonPressed() {
//        navigationController?.popViewController(animated: true)
        
        let viewModel = UserViewModel()
        let vc = LoginViewController(userViewModel: viewModel)
        navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func nextButtonPressed() {

        guard let email = contentView.emailTextField.text,
              let username = contentView.usernameTextField.text,
              let password = contentView.passwordTextField.text else {
            return
        }
        userViewModel.registerUser(email: email, username: username, password: password)
        
        let vc = WelcomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
}


// MARK: - RegistrationViewModelDelegate
extension RegistrationViewController: RegistrationViewModelDelegate {
    
    func didRegister(user: RegisterBegin) {
        print("Successfully registered user with email: \(user.email)")
    }
    
    func didFail(with error: Error) {
        print("Error in registration: \(error.localizedDescription)")
    }
}


// MARK: - UIScrollViewDelegate
extension RegistrationViewController: UIScrollViewDelegate {
    
}


// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
        
}
