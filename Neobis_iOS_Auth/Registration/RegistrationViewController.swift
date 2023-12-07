//
//  RegistrationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 07/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController, UIScrollViewDelegate {
    
    // MARK: - UI components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        
        scrollView.frame = view.bounds
        
                scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
//        scrollView.contentSize = CGSize(width: 1000, height: 1000)
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.bounces = true
        scrollView.isDirectionalLockEnabled = false
        scrollView.contentInsetAdjustmentBehavior = .always
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
//        label.text = "• From 8 to 15 characters ✅"
        //        label.text = "• From 8 to 15 characters \(checkSign)"
        return label
    }()
    
    lazy var secondRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "• Lowercase and uppercase letters"
        //        label.text = "• Lowercase and uppercase letters \(checkSign)"
        return label
    }()
    
    lazy var thirdRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "• At least one digit"
        //        label.text = "• At least one digit \(checkSign)"
        return label
    }()
    
    lazy var fourthRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.text = "• At least one special symbol (!, #, *, $, ...)"
        //        label.text = "• At least one special symbol (!, #, $) \(checkSign)"
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
    
    lazy var nextButton: NextButton = {
        let button = NextButton(type: .system)
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.darkGray, for: .normal)
        button.backgroundColor = .lightGray
        button.isReady = false
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(nextDidTap), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        setupViews()
        setupConstraints()
        
        // Add keyboard observers
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - UI setup
    
    func setupViews() {
        view.addSubview(scrollView)
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
    }
    
    func setupConstraints() {
        
        // scrollView
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // titleLabel
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(70)
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
    
    // MARK: - Actions
    
    @objc func nextButtonDidTap() {
        // Validate user input and check password strength
        // Implement logic for next button action
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        scrollView.contentInset.bottom = keyboardSize.height
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        scrollView.contentInset = .zero
    }
    
    deinit {
        // Remove observers when the view controller is deallocated
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
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
    
    
    @objc func deleteDidTap() {
    }
    
    @objc func discloseDidTap() {
    }
    
    @objc func nextDidTap() {
        nextButton.isReady = true
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
}
