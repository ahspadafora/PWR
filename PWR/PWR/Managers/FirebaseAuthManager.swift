//
//  FirebaseManager.swift
//  PWR
//
//  Created by Amber Spadafora on 10/7/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

protocol backendConfig {
    func configureBackend()
}
extension backendConfig {
    func configureBackend(){
        FirebaseApp.configure()
    }
}

class FirebaseAuthManager {
    static func logoutOfFireBase(){
        let auth = Auth.auth()
        do {
            try auth.signOut()
            UserDefaultManager.clearUserDefaults()
        }
        catch let signoutError as NSError {
            print(signoutError.localizedDescription)
        }
    }
    static func loginFirebaseWith(accessToken: String, closure: @escaping (NSError?)->Void) {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential) { (user, error) in
            guard let uid = user?.uid else { return }
            UserDefaultManager.setUserId(uid: uid)
            UserDefaultManager.setisLoggedInTo(bool: true)
            if error != nil {
                print(error!.localizedDescription)
            }
            closure(error as NSError?)
        }
    }
}
