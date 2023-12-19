//
//  WelcomeViewController.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController {
 
    lazy var welcomeView = WelcomeView()
    
    override func loadView() {
        view = welcomeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTargets()
    }
    
    func addTargets() {
        welcomeView.logoutButton.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        welcomeView.alertView.yesButton.addTarget(self, action: #selector(yesButtonTapped), for: .touchUpInside)
        welcomeView.alertView.noButton.addTarget(self, action: #selector(noButtonTapped), for: .touchUpInside)
    }


    @objc func logoutButtonPressed() {
        welcomeView.showAlert()
    }
    
    @objc func yesButtonTapped() {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
    }
    
    @objc func noButtonTapped() {
        welcomeView.hideAlert()
    }
    
}


    
    
        
