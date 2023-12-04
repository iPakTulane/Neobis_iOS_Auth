//
//  RegViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class RegViewController: UIViewController {

    // MARK: - UI componenets
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        return view
    }()
    
    lazy var titleLable: UILabel = {
        let lable = UILabel()
        return lable
    }()
    
    lazy var emailTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()

    lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var requisitesLable: UILabel = {
        let lable = UILabel()
        return lable
    }()

    lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    lazy var furtherButton: UIButton = {
        let button = UIButton()
        return button
    }()
    

    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }

    // MARK: - UI setup
    func setupViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(titleLable)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(usernameTextField)
        scrollView.addSubview(passwordTextField)
        scrollView.addSubview(requisitesLable)
        
    }
    
    func setupConstraints() {}

}
