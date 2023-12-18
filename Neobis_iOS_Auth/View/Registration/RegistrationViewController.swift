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


// MARK: - UITextFieldDelegate + Password validation
extension RegistrationViewController: UITextFieldDelegate {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupPasswordValidation()
    }

    @objc func checkRepeatPassword() {
        if registrationView.passwordTextField.text != registrationView.repeatPasswordTextField.text {
            registrationView.repeatPasswordTextField.textColor = .systemRed
            }
        checkAllData()
    }
    
    func setupPasswordValidation() {
        registrationView.passwordTextField.addTarget(self, action: #selector(validatePassword), for: .editingChanged)
        registrationView.passwordTextField.addTarget(self, action: #selector(endValidationCheck), for: .editingDidEnd)
        registrationView.passwordTextField.addTarget(self, action: #selector(startValidationCheck), for: .editingDidBegin)

//        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPassword), for: .editingChanged)
//        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPassword), for: .editingDidEnd)
        registrationView.repeatPasswordTextField.addTarget(self, action: #selector(checkRepeatPassword), for: .editingDidBegin)
    }

    @objc func validatePassword(_ textField: UITextField) {
        guard let text = textField.text else { return }

        let isValidLength = (8...15).contains(text.count)
        let containsLetters = containsCharacters(in: text, characterSet: .letters)
        let containsDigits = containsCharacters(in: text, characterSet: .decimalDigits)
        let containsSpecialChars = containsSpecialCharacters(in: text)

        updatePasswordValidationLabels(isValidLength, at: 0)
        updatePasswordValidationLabels(containsLetters, at: 1)
        updatePasswordValidationLabels(containsDigits, at: 2)
        updatePasswordValidationLabels(containsSpecialChars, at: 3)
    }

    func containsCharacters(in string: String, characterSet: CharacterSet) -> Bool {
        return string.rangeOfCharacter(from: characterSet) != nil
    }

    func containsSpecialCharacters(in string: String) -> Bool {
        let specialCharacters = CharacterSet(charactersIn: "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~")
        return containsCharacters(in: string, characterSet: specialCharacters)
    }

    func updatePasswordValidationLabels(_ condition: Bool, at index: Int) {
        let checkLabel = registrationView.passwordValidationLabels[index]
        checkLabel.textColor = condition ? UIColor.systemGreen : UIColor.systemRed
        checkLabel.text = condition ? checkLabel.text! + " ✅" : checkLabel.text! + " ❌"
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

    func checkAllData() {
        let isPasswordValid = registrationView.passwordValidationLabels.allSatisfy { $0.text!.contains("✅") }
        let isDataValid = isPasswordValid && !registrationView.emailTextField.text!.isEmpty && !registrationView.usernameTextField.text!.isEmpty
        registrationView.nextButton.isEnabled = isDataValid
        registrationView.nextButton.backgroundColor = isDataValid ? .black : .lightGray
    }

}
