//
//  LoginViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    lazy var alertLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Wrong username or password, try again!"
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 1
        label.layer.borderColor = UIColor.red.cgColor
        label.layer.borderWidth = 1
        label.layer.cornerRadius = 12
        return label
    }()
    
    lazy var globeImage: UIImageView = {
        let image = UIImage(named: "globe")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Welcome back!"
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter username"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.label.cgColor
        // Add clear button
        field.clearButtonMode = .always
        // Create a left view with an offset
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = leftView
        // Ensure the left and right views are always visible
        field.leftViewMode = .always
        field.rightViewMode = .always
        return field
    }()
    
    
    lazy var passwordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter password"
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.backgroundColor = .secondarySystemBackground
        field.layer.cornerRadius = 8
        field.layer.borderWidth = 0
        field.layer.borderColor = UIColor.label.cgColor
        
        // Add toggle button for password visibility
        field.rightViewMode = .whileEditing
        field.rightView = createPasswordVisibilityButton()
        
        // Create a left view with an offset
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: field.frame.height))
        field.leftView = leftView
        // Ensure the left and right views are always visible
        field.leftViewMode = .always
        field.rightViewMode = .always
        return field
    }()

    lazy var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(loginDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var createButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("I have no account yet", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.backgroundColor = .clear
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(createDidTap), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    func setupViews() {
        // Setup backgorund color
        view.backgroundColor = .white
        // Setup UI components
        view.addSubview(alertLabel)
        alertLabel.isHidden = true
        view.addSubview(globeImage)
        view.addSubview(titleLabel)
        view.addSubview(usernameTextField)

        view.addSubview(passwordTextField)

        view.addSubview(loginButton)
        view.addSubview(createButton)
    }
    
    func setupConstraints() {
        
        // alertLabel
        alertLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(80)
            make.width.equalTo(340)
            make.height.equalTo(50)
        }
        
        // globeImage
        globeImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(120)
            make.width.height.equalTo(220)
        }
        
        // titleLabel
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(globeImage.snp.bottom).offset(40)
            make.width.equalTo(340)
            make.height.equalTo(40)
        }
        
        // usernameTextField
        usernameTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
            make.width.equalTo(340)
            make.height.equalTo(45)
        }
        
        // passwordTextField
        passwordTextField.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.width.equalTo(340)
            make.height.equalTo(45)
        }
        
        // loginButton
        loginButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.width.equalTo(340)
            make.height.equalTo(45)
        }
        
        // createButton
        createButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).offset(25)
            make.width.equalTo(340)
            make.height.equalTo(45)
        }
        
    }
    
    
    @objc func loginDidTap() {
//        let vc = WelcomeViewController(vm: viewModel, welcomeViewController: self)
        let vc = WelcomeViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        vc.titleLabel.text = "Welcome back!"
    }
    
    @objc func createDidTap() {
//        alertLabel.isHidden = true
        let vc = RegistrationViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    
    // MARK: - Helper functions
    
    private func createPasswordVisibilityButton() -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "eyeClosed"), for: .normal)
        button.setImage(UIImage(named: "eyeOpened"), for: .selected)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        return button
    }
    
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            passwordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
        }
    }
    
    
    
}


