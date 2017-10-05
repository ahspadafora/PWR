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
        if let senatorXMLFile = getSenatorXMLUrl() {
            let (senators, stateSenateMap) = getSenators(url: senatorXMLFile)
            
            if let rootView = self.window?.rootViewController as? UINavigationController {
                if let vc = rootView.viewControllers[0] as? StateCollectionViewController {
                    vc.senatorStateMap = stateSenateMap
                }
            }
        }
        return true
    }


    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }
}

func getSenatorXMLUrl() -> URL?{
    if let path = Bundle.main.url(forResource: "senators", withExtension: "xml") {
        return path
    } else {
        return nil
    }
}

func getSenators(url: URL) -> ([Senator], [String: [Senator]]){
    let parser = XMLParser(contentsOf: url)
    let parserDelegate = ParserDelegate()
    parser?.delegate = parserDelegate
    parser?.parse()
    let senators: [Senator] = parserDelegate.senators
    var stateSenatorMap: [String: [Senator]] = [:]
    for senator in senators {
        if let _ = stateSenatorMap[senator.state] {
            stateSenatorMap[senator.state]?.append(senator)
        } else {
            stateSenatorMap[senator.state] = [senator]
        }
    }
    print(stateSenatorMap.count)
    return (senators, stateSenatorMap)
}

