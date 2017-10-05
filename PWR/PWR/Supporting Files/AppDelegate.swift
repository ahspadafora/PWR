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
        if let senatorXMLFile = SenatorGetter().getSenatorXMLUrl() {
            let (_, stateSenateMap) = SenatorGetter().getSenators(url: senatorXMLFile)
            if let rootView = self.window?.rootViewController as? UINavigationController {
                if let vc = rootView.viewControllers[0] as? StateCollectionViewController {
                    vc.senatorStateMap = stateSenateMap
                }
            }
        }
        return true
    }
}



