//
//  FirebaseManager.swift
//  PWR
//
//  Created by Amber Spadafora on 10/7/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import Firebase

protocol backendConfig {
    func configureBackend()
}
extension backendConfig {
    func configureBackend(){
        FirebaseApp.configure()
    }
}

class FirebaseManager {
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
}
