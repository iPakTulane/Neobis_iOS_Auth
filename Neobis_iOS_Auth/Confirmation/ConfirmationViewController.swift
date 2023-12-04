//
//  ConfirmationViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class ConfirmationViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textColor = .black
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "We've sent you a message with reference for you to complete registration to your email"
//        label.text = "We've sent you an email with reference for you to complete registration to \(email)"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = """
        If you don't see our message,
        don't waste your time and
        better check your Spam box
        
        (´○• ω •○`)
        """
        return label
    }()
    
    lazy var emailImage: UIImageView = {
        let image = UIImage(named: "checkEmail")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var noEmailButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Email didn't come", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(noEmailDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.alpha = 1.0
        return view
    }()

    
    lazy var alertView: EmailAlertView = {
        let alertView = EmailAlertView()
        alertView.backgroundColor = .white
        alertView.alpha = 1.0
        alertView.isHidden = true
        return alertView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        setupAlert()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(subtitleLabel)
        containerView.addSubview(emailImage)
        containerView.addSubview(noEmailButton)
        view.addSubview(alertView)
    }
    
    func setupConstraints() {
        
        // containerView
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }

        // titleLabel
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(containerView.snp.top).offset(100)
            make.left.equalTo(containerView.snp.top).offset(20)
            make.right.equalTo(containerView.snp.right).offset(-20)
        }
        
        // subtitleLabel
        subtitleLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(25)
            make.left.equalTo(containerView.snp.top).offset(20)
            make.right.equalTo(containerView.snp.right).offset(-20)
        }
        
        // emailImage
        emailImage.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(35)
            make.width.height.equalTo(315)
        }
        
        // noEmailButton
        noEmailButton.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalTo(containerView.snp.bottom).offset(-30)
            make.left.equalTo(containerView.snp.top).offset(20)
            make.right.equalTo(containerView.snp.right).offset(-20)
        }
    }
    
    func setupAlert() {

        alertView.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(250)
        }
        
        // Add targets
        alertView.okButton.addTarget(self, action: #selector(okButtonTapped), for: .touchUpInside)
                
        // Set actions for "OK" buttons
        alertView.okAction = {
            print("OK tapped")
        }

    }
    

    @objc func noEmailDidTap() {
        showAlert()
    }
    
    
    func showAlert() {
        // containerView
        containerView.backgroundColor = .darkGray
        containerView.alpha = 0.5
        // alertView
        alertView.isHidden = false
        view.bringSubviewToFront(alertView)
    }
    
    @objc func okButtonTapped() {
        printContent("User understood the spam note")
        self.dismiss(animated: true, completion: nil)
//        let vc = LoginViewController()
//        vc.modalPresentationStyle = .fullScreen
//        present(vc, animated: true, completion: nil)
    }
    
}
