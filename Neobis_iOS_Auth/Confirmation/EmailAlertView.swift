//
//  EmailAlertView.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 03/12/23.
//


import UIKit

class EmailAlertView: UIView {

    // Callback closure for button actions
    var okAction: (() -> Void)?

    // UI components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.numberOfLines = 0
        label.text = """
        We've sent another request
        on your email
        """
//        label.text = "We've sent another request on \(email)"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.text = """
        You'll have only 5 mins
        to confirm your registration
        """
        label.textColor = .darkGray
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    lazy var okButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Understood!", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 12
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
        addSubview(okButton)

        // Set up constraints
        
        // titleLabel
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
//            make.width.height.equalTo(40)
        }
        
        // subtitleLabel
        subtitleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()

//            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
//            make.width.height.equalTo(40)
        }
        
        // yesButton
        okButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(25)
            make.left.equalToSuperview().inset(15)
            make.right.equalToSuperview().inset(15)
            make.height.equalTo(45)
        }
        
        // Call updateConstraints() to update constraints after adding subviews
        setNeedsUpdateConstraints()
    }

    override func updateConstraints() {
        // Add constraints here
        // (Adjust constraints according to your design preferences)

        super.updateConstraints()
    }

    // MARK: - Button Actions

    @objc private func okButtonTapped() {
        okAction?()
    }


    // Public function to set title and subtitle
//    func configure(title: String, subtitle: String) {
//        titleLabel.text = title
//        subtitleLabel.text = subtitle
//    }
    
}

