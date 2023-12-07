//
//  AppDelegate.swift
//  Neobis_iOS_Auth
//
//  Created by iPak Tulane on 30/11/23.
//


//import UIKit
//
//@main
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        
////        let welcomeViewController = WelcomeViewController(coder: NSCoder())
////        let rootViewController = ViewController(vm: ViewModel())
//
////        let rootViewController = RegistrationViewController()
////        window?.rootViewController = rootViewController
////        window?.makeKeyAndVisible()
////        return true
//        
//        let viewController = RegistrationViewController()
//        let navigationController = UINavigationController(rootViewController: viewController)
//        navigationController.modalPresentationStyle = .fullScreen
//        window?.rootViewController = navigationController
//        self.window?.makeKeyAndVisible()
//        return true
//    }
//}
//
//
//    

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)

        let viewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        return true
    }
}

