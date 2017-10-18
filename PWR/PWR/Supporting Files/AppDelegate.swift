//
//  AppDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, backendConfig {

    var window: UIWindow?
    lazy var coreDataStack = CoreDataStack(modelName: "CoreDataModel")

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configureBackend()
        UIApplication.shared.statusBarStyle = .default
        StyleManager.instance.applyStylingAppwide()
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        //coreDataStack.managedContext
        let state = State(context: coreDataStack.managedContext)
        state.abbreviation = "Dummy Abbreviation"
        state.fullname = "Dummy Name"
        coreDataStack.managedContext.insert(state)
        
        //UserDefaultManager.clearUserDefaults()
        if UserDefaultManager.userIsSignedIn {
            goToHomeVC()
        } else {
            goToLoginVC()
        }
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    func applicationWillTerminate(_ application: UIApplication) {
        coreDataStack.saveContext()
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        guard let sourceApplication = options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String else { return false }
        let annotation = options[UIApplicationOpenURLOptionsKey.annotation] as? String
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



