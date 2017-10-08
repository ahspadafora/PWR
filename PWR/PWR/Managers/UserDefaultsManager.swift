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
            guard let dict = userDefaults.dictionary(forKey: "userStateDict"),
            let uid = self.storedUserId,
            let storedStateAbbreviation = dict[uid] as? String else { return nil }
            let states = StateGetter().states
            return states.first {$0.abbreviation == storedStateAbbreviation }
        }
    }
    
    static var userIsSignedIn: Bool {
        get {
            return userDefaults.value(forKey: "isLoggedIn") as? Bool ?? false
            }
    }
    
    static func clearUserDefaults(){
        userDefaults.set(false, forKey: "isLoggedIn")
        userDefaults.removeObject(forKey: "userId")
    }
    
    
    static func setStoredState(abbreviation: String){
        if let uid = self.storedUserId {
            let userStateDictionary: [String: String] = [uid:abbreviation]
            userDefaults.set(userStateDictionary, forKey: "userStateDict")
        }
    }
    
    static func setisLoggedInTo(bool: Bool) {
        userDefaults.set(bool, forKey: "isLoggedIn")
    }
    
    static func setUserId(uid: String){
        userDefaults.set(uid, forKey: "userId")
    }
}
