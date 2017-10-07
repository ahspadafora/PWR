//
//  AppDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import FBSDKCoreKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, backendConfig {

    var window: UIWindow?

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureBackend()
        
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        // UserDefaultManager.clearUserDefaults()
        if UserDefaultManager.userIsSignedIn {
            goToHomeVC()
        } else {
            goToLoginVC()
        }
        return true
    }
    
//    - (BOOL)application:(UIApplication *)application
//    openURL:(NSURL *)url
//    sourceApplication:(NSString *)sourceApplication
//    annotation:(id)annotation {
//    return [[FBSDKApplicationDelegate sharedInstance] application:application
//    openURL:url
//    sourceApplication:sourceApplication
//    annotation:annotation];
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let sourceApplication = UIApplicationOpenURLOptionsKey.sourceApplication.rawValue
        let annotation = UIApplicationOpenURLOptionsKey.annotation.rawValue
        return FBSDKApplicationDelegate.sharedInstance().application(app, open: url, sourceApplication: sourceApplication, annotation: annotation)
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



