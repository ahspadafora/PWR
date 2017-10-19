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
    
    static var storedState: St? {
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
    
    // CORE DATA VERSION - TO BE IMPLEMENTED
    static func setUsersState(objectId: URL){
        if let uid = self.storedUserId {
            let usersStateDict: [String: URL] = [uid: objectId]
            userDefaults.set(usersStateDict, forKey: "usersStoredStateDict")
            userDefaults.synchronize()
        }
    }
    // CORE DATA VERSION - TO BE IMPLEMENTED
    static var usersStoredState: URL? {
        get {
            guard let dict = userDefaults.dictionary(forKey: "usersStoredStateDict"),
                let uid = self.storedUserId,
                let objectId = dict[uid] as? URL else {
                    print("couldn't cast objectID to URL")
                    return nil
                }
            return objectId // returns the objectId for the storedState
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
