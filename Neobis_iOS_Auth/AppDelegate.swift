//
//  AppDelegate.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = LoginViewController()
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .fullScreen
        window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        return true
    }
}
