//
//  WelcomeViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 45)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Welcome!"
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        label.text = "Lorby is your personal tutor"
        return label
    }()
    
    lazy var welcomeImage: UIImageView = {
        let image = UIImage(named: "welcome")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var logoutButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Log out", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(logoutDidTap), for: .touchUpInside)
        return button
    }()
    
    lazy var containerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.alpha = 1.0
        return view
    }()

    
    lazy var alertView: LogoutAlertView = {
        let alertView = LogoutAlertView()
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
        containerView.addSubview(welcomeImage)
        containerView.addSubview(logoutButton)
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
            make.top.equalTo(containerView.snp.top).offset(130)
            make.width.equalTo(275)
            make.height.equalTo(35)
        }
        
        // subtitleLabel
        subtitleLabel.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(310)
            make.height.equalTo(30)
        }
        
        // welcomeImage
        welcomeImage.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
            make.width.height.equalTo(315)
        }
        
        // logoutButton
        logoutButton.snp.makeConstraints{ make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.bottom.equalTo(containerView.snp.bottom).offset(-75)
            make.width.equalTo(300)
            make.height.equalTo(25)
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
        alertView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        alertView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
                
        // Set actions for "Yes" and "No" buttons
        alertView.yesAction = {
            print("Yes tapped")
        }
        alertView.noAction = {
            print("No tapped")
        }
    }
    

    @objc func logoutDidTap() {
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
    
    @objc func yesButtonTapped() {
        
        self.dismiss(animated: true)
        
        let viewController = LoginViewController()
        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    @objc func noButtonTapped() {
        // containerView
        containerView.backgroundColor = .white
        containerView.alpha = 1.0
        // alertView
        alertView.isHidden = true
        
//        self.dismiss(animated: true)
        
//        let viewController = WelcomeViewController()
//        navigationController?.pushViewController(viewController, animated: true)
        
    }
    
}
