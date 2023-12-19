//
//  RegistrationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 07/12/23.
//


import UIKit
import SnapKit


class RegistrationViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate {
    
    lazy var registrationView = RegistrationView()
    lazy var registrationViewModel = AuthViewModel()
    
    override func loadView() {
        view = registrationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addNavigation()
        addTargets()
        addDelegates()
    }
    
    func addNavigation() {
        self.navigationItem.title = "Registration"
        let backButton = UIBarButtonItem(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(backButtonPressed))
        self.navigationItem.leftBarButtonItem = backButton
    }
    
    func addTargets() {
        registrationView.nextButton.addTarget(self, action: #selector(nextButtonPressed), for: .touchUpInside)
        registrationView.passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        registrationView.passwordTextField.addTarget(self, action: #selector(endValidationCheck), for: .editingDidEnd)
        registrationView.passwordTextField.addTarget(self, action: #selector(startValidationCheck), for: .editingDidBegin)
        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPassword), for: .editingDidEnd)
        
        // Add targets to handle password checking
        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(checkSecondPassword), for: .editingChanged)
        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(editSecondPassword), for: .editingChanged)
    }
    
    func addDelegates() {
        registrationView.scrollView.delegate = self
        registrationView.emailTextField.delegate = self
        registrationView.usernameTextField.delegate = self
        registrationView.passwordTextField.delegate = self
        registrationView.repeatPasswordTextField.delegate = self
    }
    
    @objc func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonPressed() {
        
        guard let email = registrationView.emailTextField.text,
              let username = registrationView.usernameTextField.text,
              let password = registrationView.passwordTextField.text
        else {
            return
        }
        // Move logic to AuthViewModel
        registrationViewModel.register(email: email, username: username, password: password) { [weak self] result in
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
                }
            }
        }
    }
    
    @objc func validatePassword(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        let passwordValidationResult = registrationViewModel.validatePassword(text)
        
        // Update UI based on validation result
        updatePasswordValidationLabels(passwordValidationResult.isValidLength, at: 0)
        updatePasswordValidationLabels(passwordValidationResult.containsLetters, at: 1)
        updatePasswordValidationLabels(passwordValidationResult.containsDigits, at: 2)
        updatePasswordValidationLabels(passwordValidationResult.containsSpecialChars, at: 3)
        
        // ... Other UI updates
    }
    
    @objc func endValidationCheck() {
        for label in registrationView.passwordValidationLabels {
            if !label.text!.contains("✅") {
                label.textColor = .systemRed
                label.text?.append("❌")
            }
        }
        checkAllData()
    }
    
    @objc func startValidationCheck() {
        for label in registrationView.passwordValidationLabels {
            if label.text!.contains("❌") {
                label.textColor = .systemRed
                label.text?.removeLast(2)
            }
        }
        registrationView.passwordTextField.textColor = .black
    }
    
    @objc func checkRepeatPassword() {
        if registrationView.passwordTextField.text != registrationView.repeatPasswordTextField.text {
            registrationView.repeatPasswordTextField.textColor = .systemRed
        }
        checkAllData()
    }
    
    
    func updatePasswordValidationLabels(_ condition: Bool, at index: Int) {
        let checkLabel = registrationView.passwordValidationLabels[index]
        
        // Remove existing checkmark or crossmark
        checkLabel.text = checkLabel.text?.replacingOccurrences(of: " ✅", with: "").replacingOccurrences(of: " ❌", with: "")
        
        // Add new checkmark or crossmark based on the condition
        if condition {
            checkLabel.textColor = .systemGreen
            checkLabel.text?.append(" ✅")
        } else {
            checkLabel.textColor = .systemRed
            checkLabel.text?.append(" ❌")
        }
    }
    
    
    @objc func checkSecondPassword() {
        let isFirstPasswordValid = !registrationView.passwordTextField.text!.isEmpty
        let isSecondPasswordValid = !registrationView.repeatPasswordTextField.text!.isEmpty
        
        if isFirstPasswordValid && isSecondPasswordValid {
            if registrationView.passwordTextField.text != registrationView.repeatPasswordTextField.text {
                // Passwords do not match
                registrationView.repeatPasswordTextField.textColor = .systemRed
                
                registrationView.nextButton.snp.updateConstraints { make in
                    make.top.equalTo(registrationView.repeatPasswordTextField.snp.bottom).offset(50)
                }
            } else {
                // Passwords match
                registrationView.repeatPasswordTextField.textColor = .black
                
                registrationView.nextButton.snp.updateConstraints { make in
                    make.top.equalTo(registrationView.repeatPasswordTextField.snp.bottom).offset(25)
                }
            }
        }
        checkAllData()
    }

    
    @objc func editSecondPassword() {
        registrationView.repeatPasswordTextField.textColor = .black
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func checkAllData() {
        // Validate password using allSatisfy
        let isPasswordValid = registrationView.passwordValidationLabels.allSatisfy { $0.text!.contains("✅") }

        // Check if email and username are not empty
        let isEmailNotEmpty = !registrationView.emailTextField.text!.isEmpty
        let isUsernameNotEmpty = !registrationView.usernameTextField.text!.isEmpty

        // Check if passwords match
        let isRepeatPasswordMatch = registrationView.passwordTextField.text == registrationView.repeatPasswordTextField.text

        // Validate email format
        let isEmailValid = isValidEmail(registrationView.emailTextField.text ?? "")

        // Check if all conditions are satisfied
        let isDataValid = isPasswordValid && isEmailNotEmpty && isUsernameNotEmpty && isRepeatPasswordMatch && isEmailValid

        // Enable/disable the next button based on data validity
        registrationView.nextButton.isEnabled = isDataValid

        // Set button appearance only when all conditions are met
        if isDataValid {
            registrationView.nextButton.backgroundColor = .black
            registrationView.nextButton.setTitleColor(.white, for: .normal)
        }
    }

}
