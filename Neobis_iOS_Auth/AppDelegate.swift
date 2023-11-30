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
//        window?.rootViewController = WelcomeViewController(coder: <#NSCoder#>)
//        window?.makeKeyAndVisible()
//        return true
//    }
//}


import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        // Assuming WelcomeViewController has an initializer that takes NSCoder
//        let welcomeViewController = WelcomeViewController(coder: NSCoder())
        let welcomeViewController = WelcomeViewController()
        // Set your view controller as the root view controller
        window?.rootViewController = welcomeViewController
        
        // Make the window visible
        window?.makeKeyAndVisible()
        
        return true
    }
}


//window?.rootViewController = ViewController(vm: WeatherViewModel())
