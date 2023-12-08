//
//  RegistrationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 07/12/23.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController {
    
    // Define a variable to keep track of the active text field
    var activeTextField: UITextField?
    
    // MARK: - UI components
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        
//        scrollView.frame = view.bounds
        
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1000)
        
        
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 1.0
        scrollView.bounces = true
        scrollView.isDirectionalLockEnabled = false
        scrollView.contentInsetAdjustmentBehavior = .always
        scrollView.isScrollEnabled = true
        scrollView.isUserInteractionEnabled = true
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
        return label
    }()
    
    lazy var secondRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .systemGreen
        label.textAlignment = .left
        label.text = "• Lowercase and uppercase letters"
        //        label.text = "• Lowercase and uppercase letters ✅"
        return label
    }()
    
    lazy var thirdRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .red
        label.textAlignment = .left
        label.text = "• At least one digit"
        //        label.text = "• At least one digit ❌"
        //        label.text = "• At least one digit ✅"
        return label
    }()
    
    lazy var fourthRequisiteLable: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .lightGray
        //        label.textColor = .systemGreen
        label.textAlignment = .left
        label.text = "• At least one special symbol (!, #, *, $, ...)"
        //        label.text = "• At least one special symbol (!, #, $) ✅"
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
        button.addTarget(self, action: #selector(nextButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initialization
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegates()
        setupNavigation()
        setupViews()
        setupConstraints()
        setupKeyboardObservers()
    }
    
    // MARK: - UI setup
    
    func setupKeyboardObservers() {
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        // Register for keyboard notifications
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown), name: UIResponder.keyboardDidShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
    }
    
    // Called when the keyboard is about to be shown
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let userInfo = notification.userInfo,
              let keyboardSize = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size else {
            return
        }
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        if let activeTextField = self.activeTextField {
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            if !aRect.contains(activeTextField.frame.origin) {
                scrollView.scrollRectToVisible(activeTextField.frame, animated: true)
            }
        }
    }
    
    // Called when the keyboard is about to be hidden
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset = .zero
        scrollView.scrollIndicatorInsets = .zero
    }
    
    // UITextFieldDelegate method
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    // Add this deinit method to remove observers
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    
    
    
    
    
//    @objc func keyboardWasShown(notification: NSNotification) {
//        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
//            let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
//            scrollView.contentInset = contentInsets
//            scrollView.scrollIndicatorInsets = contentInsets
//            
//            // If active text field is hidden by keyboard, scroll it so it's visible
//            var aRect = self.view.frame
//            aRect.size.height -= keyboardSize.height
//            if let activeField = self.activeTextField, !aRect.contains(activeField.frame.origin) {
//                scrollView.scrollRectToVisible(activeField.frame, animated: true)
//            }
//        }
//    }

//    @objc func keyboardWillBeHidden(notification: NSNotification) {
//        let contentInsets = UIEdgeInsets.zero
//        scrollView.contentInset = contentInsets
//        scrollView.scrollIndicatorInsets = contentInsets
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
    
    
    
    func setupDelegates() {
        // Set delegate for scroll view
        scrollView.delegate = self
        // Set delegates for text fields
        emailTextField.delegate = self
        usernameTextField.delegate = self
        passwordTextField.delegate = self
        repeatPasswordTextField.delegate = self
    }
    
    func setupNavigation() {
        self.navigationItem.title = "Registration"
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "arrow")
        backButton.tintColor = .black
        // Set the target and action for the back button
        backButton.target = self
        backButton.action = #selector(backButtonTapped)
        self.navigationItem.leftBarButtonItem = backButton
    }
    
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
    
    // MARK: - Actions
    
    @objc func nextButtonDidTap() {
        // Validate user input and check password strength
        // Implement logic for next button action
        nextButton.isReady = true
        nextButton.setTitleColor(.white, for: .normal)
        nextButton.backgroundColor = .black
        
        let viewController = ConfirmationViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    
    // MARK: - Keyboard Handling
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        scrollView.contentInset.bottom = keyboardFrame.height
//        if let activeField = findActiveTextField() {
//            let fieldFrame = activeField.convert(activeField.bounds, to: scrollView)
//            let bottomOffset = keyboardFrame.height - (scrollView.bounds.height - fieldFrame.maxY)
//            scrollView.contentOffset.y += max(0, bottomOffset)
//        }
//        
////        func findActiveTextField() -> UITextField? {
////            return view.findFirstResponder() as? UITextField
////        }
//    }
    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        scrollView.contentInset = .zero
//    }
//    
//    deinit {
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    func findActiveTextField() -> UITextField? {
//        return view.findFirstResponder() as? UITextField
//    }

   ///////////
    
 
    
    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        scrollView.contentInset.bottom = keyboardSize.height
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        scrollView.contentInset = .zero
//    }
    
//    
//    @objc func keyboardWillShow(_ notification: Notification) {
//        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
//        scrollView.contentInset.bottom = keyboardSize.height
//    }
//    
//    @objc func keyboardWillHide(_ notification: Notification) {
//        scrollView.contentInset = .zero
//    }
//    
//    deinit {
//        // Remove observers when the view controller is deallocated
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
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
    
    @objc func backButtonTapped() {
        // Handle back button tap
        self.navigationController?.popViewController(animated: true)
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


// MARK: - UITextFieldDelegate

extension RegistrationViewController: UITextFieldDelegate {
    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Scroll the scrollView to make the active text field visible
//        scrollToTextField(textField)
//    }
    
    // Helper method to scroll to the active text field
    private func scrollToTextField(_ textField: UITextField) {
        let rect = textField.convert(textField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(rect, animated: true)
    }
    
    
//    // UITextFieldDelegate method
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        // Set the activeTextField when a text field begins editing
//        self.activeTextField = textField
//    }
//    
//    // Call this method to resign the active text field when needed
//    func resignActiveTextField() {
//        activeTextField?.resignFirstResponder()
//        activeTextField = nil
//    }
//    
    
    
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
