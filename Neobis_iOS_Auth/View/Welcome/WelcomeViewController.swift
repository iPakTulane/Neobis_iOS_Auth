//
//  WelcomeViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
 
    let contentView = WelcomeView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addView()
        addTargets()
    }
    
    func addView(){
        view.addSubview(contentView)
        contentView.snp.makeConstraints{ make in
            make.edges.equalToSuperview()
        }
    }
    
    func addTargets() {
        contentView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        contentView.alertView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        contentView.alertView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }


    @objc func logoutButtonPressed() {
        contentView.showAlert()
    }
    
    @objc func yesButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func noButtonTapped() {
        contentView.hideAlert()
    }
    
}


    
    
        
