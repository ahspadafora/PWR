//
//  UserDefaultsManager.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import FirebaseAuth

class UserDefaultManager{
    static let userDefaults = UserDefaults.standard
    
    static var storedUserId: String? {
        get {
            return userDefaults.value(forKey: "userId") as? String
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
    
    // CORE DATA VERSION - TO BE IMPLEMENTED
    static func setUsersState(stateName: String){
        if let uid = self.storedUserId {
            let usersStateDict: [String: String] = [uid: stateName]
            userDefaults.set(usersStateDict, forKey: "usersStoredStateDict")
            userDefaults.synchronize()
        }
    }
    // CORE DATA VERSION - TO BE IMPLEMENTED
    static var getUsersStoredState: String? {
        get {
            guard let dict = userDefaults.dictionary(forKey: "usersStoredStateDict"),
                let uid = self.storedUserId,
                let stateName = dict[uid] as? String else {
                    print("no state name associated with user \(self.storedUserId)")
                    return nil
                }
            return stateName // returns the name for the storedState
        }
    }
    
    static func setisLoggedInTo(bool: Bool) {
        userDefaults.set(bool, forKey: "isLoggedIn")
    }
    
    // stored uid is the user's firebaseUID
    static func setUserId(uid: String){
        userDefaults.set(uid, forKey: "userId")
    }
}
