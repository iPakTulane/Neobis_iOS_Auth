//
//  RegistrationView.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 14/12/23.
//

import UIKit
import SnapKit

class RegistrationView: UIView {

    var passwordValidationLabels: [UILabel] = []
    
    // Define a variable to keep track of the active text field
    var activeTextField: UITextField?
    
    // MARK: - UI components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.bounces = true
        scrollView.isDirectionalLockEnabled = false
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Create \na Lorby account"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Enter email"
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
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        return view
    }()
    
    lazy var firstRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .systemGreen
        label.textAlignment = .left
        label.text = "• From 8 to 15 characters"
        return label
    }()
    
    lazy var secondRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .systemGreen
        label.textAlignment = .left
        label.text = "• Lowercase and uppercase letters"
        return label
    }()
    
    lazy var thirdRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .red
        label.textAlignment = .left
        label.text = "• At least one digit"
        return label
    }()
    
    lazy var fourthRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .systemGreen
        label.textAlignment = .left
        label.text = "• At least one special symbol (!, #, *, $, ...)"
        return label
    }()
    
    lazy var repeatPasswordTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Repeat password"
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
    
    lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 12
        return button
    }()
    
    // MARK: - INITS
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        backgroundColor = .white
        setupViews()
        setupConstraints()
    }

    // MARK: -
    func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(emailTextField)
        
        scrollView.addSubview(usernameTextField)
        
        scrollView.addSubview(passwordTextField)
        
        scrollView.addSubview(containerView)
        containerView.addSubview(firstRequisiteLable)
        containerView.addSubview(secondRequisiteLable)
        containerView.addSubview(thirdRequisiteLable)
        containerView.addSubview(fourthRequisiteLable)
        
        scrollView.addSubview(repeatPasswordTextField)
        
        scrollView.addSubview(nextButton)
        
        passwordValidationLabels = [
                    firstRequisiteLable,
                    secondRequisiteLable,
                    thirdRequisiteLable,
                    fourthRequisiteLable
        ]
    }
    
    func setupConstraints() {
        
        // scrollView
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // titleLabel
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(50)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(100)
        }
        
        // emailTextField
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        // usernameTextField
        usernameTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        // passwordTextField
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(usernameTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        // containerView
        containerView.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(80)
        }
        
        // firstRequisiteLable
        firstRequisiteLable.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top)
            make.left.equalTo(containerView.snp.left).offset(5)
            make.right.equalTo(containerView.snp.right)
            make.height.equalTo(20)
        }
        
        // secondRequisiteLable
        secondRequisiteLable.snp.makeConstraints { make in
            make.top.equalTo(firstRequisiteLable.snp.bottom)
            make.left.equalTo(containerView.snp.left).offset(5)
            make.right.equalTo(containerView.snp.right)
            make.height.equalTo(20)
        }
        
        // thirdRequisiteLable
        thirdRequisiteLable.snp.makeConstraints { make in
            make.top.equalTo(secondRequisiteLable.snp.bottom)
            make.left.equalTo(containerView.snp.left).offset(5)
            make.right.equalTo(containerView.snp.right)
            make.height.equalTo(20)
        }
        
        // fourthRequisiteLable
        fourthRequisiteLable.snp.makeConstraints { make in
            make.top.equalTo(thirdRequisiteLable.snp.bottom)
            make.left.equalTo(containerView.snp.left).offset(5)
            make.right.equalTo(containerView.snp.right)
            make.height.equalTo(20)
        }
        
        // repeatPasswordTextField
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
        
        // nextButton
        nextButton.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(50)
        }
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
            repeatPasswordTextField.isSecureTextEntry = false
        } else {
            passwordTextField.isSecureTextEntry = true
            repeatPasswordTextField.isSecureTextEntry = true
        }
    }
}


