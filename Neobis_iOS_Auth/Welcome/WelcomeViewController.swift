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

    
//    weak var loginViewController: LoginViewController?
    
//    var welcomeView = WelcomeView()
    
    //    let viewModel: ViewModelType
    
    //    init(vm: ViewModelType, loginViewController: LoginViewController) {
    //        viewModel = vm
    //        self.loginViewController = loginViewController
    //        super.init(nibName: nil, bundle: nil)
    //    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(subtitleLabel)
        view.addSubview(welcomeImage)
        view.addSubview(logoutButton)
    }
    
    func setupConstraints() {
        
        // titleLabel
        titleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(130)
            make.width.equalTo(275)
            make.height.equalTo(35)
        }
        
        // subtitleLabel
        subtitleLabel.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.width.equalTo(310)
            make.height.equalTo(30)
        }

        // welcomeImage
        welcomeImage.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.height.equalTo(315)
        }
        
        // logoutButton
        logoutButton.snp.makeConstraints{ make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(75)
            make.width.equalTo(300)
            make.height.equalTo(25)
        }
    }
    
    
    
//    func setupView() {
//        view.addSubview(welcomeView)
//    }
//    
//    func setupConstriant() {
//        welcomeView.snp.makeConstraints{ make in
//            make.edges.equalToSuperview()
////            make.top.equalTo(view.snp.top)
////            make.bottom.equalTo(view.snp.bottom)
////            make.left.equalTo(view.snp.left)
////            make.right.equalTo(view.snp.right)
//        }
//    }
//
//    func setupTarget() {
//        welcomeView.logoutButton.addTarget(self, action: #selector(logoutDidTap), for: .touchUpInside)
//    }
    
    @objc func logoutDidTap() {
        self.dismiss(animated: true, completion: nil)
        //        let vc = LoginViewController(vm: viewModel, loginViewController: self)
        //        vc.modalPresentationStyle = .fullScreen
        //        present(vc, animated: true, completion: nil)
    }
    
}
