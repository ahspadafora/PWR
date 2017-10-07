//
//  AppDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //UserDefaultManager.clearUserDefaults()
        if UserDefaultManager.userIsSignedIn {
            goToHomeVC()
        } else {
            goToLoginVC()
        }
        return true
    }
    
    func goToLoginVC(){
        let storyboard = UIStoryboard(name: "LoginStoryboard", bundle: nil)
        let loginVC = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = loginVC
        self.window?.makeKeyAndVisible()
    }
    
    func goToHomeVC(){
        let storyboard = UIStoryboard(name: "Home", bundle: nil)
        let homeVC = storyboard.instantiateInitialViewController()
        self.window?.rootViewController = homeVC
        self.window?.makeKeyAndVisible()
    }
}



