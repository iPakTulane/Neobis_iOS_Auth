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
        navigationController?.popViewController(animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // Handle scroll events
        // This method is called when the content view of the scroll view is scrolled.
        // You can implement custom logic based on the scrolling behavior.

        // Get the current vertical scroll offset
        let yOffset = scrollView.contentOffset.y

        // Example: Print the scroll offset to the console
        print("Vertical Scroll Offset: \(yOffset)")

        // Example: Change the background color based on the scroll offset
        let maxScrollOffset: CGFloat = 100.0
        let alpha = min(1.0, yOffset / maxScrollOffset)
        self.view.backgroundColor = UIColor.blue.withAlphaComponent(alpha)
        
        // Add your custom logic here based on the scroll offset or any other scrolling behavior.
    }
    
}


extension UIView {
    func findFirstResponder() -> UIResponder? {
        if isFirstResponder {
            return self
        }
        for subview in subviews {
            if let responder = subview.findFirstResponder() {
                return responder
            }
        }
        return nil
    }
}


// MARK: - UITextFieldDelegate
extension RegistrationViewController: UITextFieldDelegate {
        
}
