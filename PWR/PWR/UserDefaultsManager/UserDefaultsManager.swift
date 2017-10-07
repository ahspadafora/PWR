//
//  UserDefaultsManager.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class UserDefaultManager{
    private init(){}
    static let userDefaults = UserDefaults.standard
    
    static var storedUserId: String? {
        get {
            return userDefaults.value(forKey: "userId") as? String
        }
    }
    
    static var storedState: State? {
        get {
            guard let stateName = userDefaults.value(forKey: "State") as? String else {
                return nil
            }
            let states = StateGetter().states
            return states.first {$0.abbreviation == stateName}
        }
    }
    
    static var userIsSignedIn: Bool {
        get {
            guard let loggedIn = userDefaults.value(forKey: "isLoggedIn") as? Bool else {
                return false
            }
            return loggedIn
        }
    }
    
    static func clearUserDefaults(){
        userDefaults.removeObject(forKey: "isLoggedIn")
        userDefaults.removeObject(forKey: "State")
        userDefaults.removeObject(forKey: "userId")
    }
    
    
    static func setStoredState(abbreviation: String){
        userDefaults.set(abbreviation, forKey: "State")
    }
    
    static func setisLoggedInTo(bool: Bool) {
        userDefaults.set(bool, forKey: "isLoggedIn")
    }
    
    static func setUserId(uid: String){
        userDefaults.set(uid, forKey: "userId")
    }
}