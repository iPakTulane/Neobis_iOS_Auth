//
//  LogoutAlertView.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit

class LogoutAlertView: UIView {

    // UI components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.text = "Do you want to log out?"
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "Are you sure?"
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()

    lazy var yesButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Yes, sure thing!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
        return button
    }()

    lazy var noButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("No, keep going", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(.black, for: .normal)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }

    private func setupUI() {

        backgroundColor = .white
        layer.cornerRadius = 12
        layer.masksToBounds = true

        // Add UI components to the view hierarchy
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(yesButton)
        addSubview(noButton)

        // Set up constraints
        
        // titleLabel
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
        }
        
        // subtitleLabel
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(40)
        }
        
        // yesButton
        yesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(subtitleLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(45)
        }
        
        // noButton
        noButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(yesButton.snp.bottom).offset(15)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.width.height.equalTo(45)
        }
        
        // Call updateConstraints() to update constraints after adding subviews
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        // Add constraints here
        // (Adjust constraints according to your design preferences)
        super.updateConstraints()
    }
    
}
