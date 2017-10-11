//
//  FBLoginButtonDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/9/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import FBSDKLoginKit

class FBLoginButtonDelegate: NSObject, FBSDKLoginButtonDelegate {
    
    var fbUserLoggedInDelegate: FBUserLoggedInDelegate
    
    var fbButton: FBSDKLoginButton {
        let fbBttn = FBSDKLoginButton()
        fbBttn.delegate = self
        fbBttn.loginBehavior = .web
        return fbBttn
    }
    
    init(fbDelegate: FBUserLoggedInDelegate){
        self.fbUserLoggedInDelegate = fbDelegate
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if result.isCancelled == true {
            print("user cancelled login")
        } else if let token = result.token {
            if let tokenString = token.tokenString {
                FirebaseAuthManager.loginFirebaseWith(accessToken: tokenString, closure: { (error) in
                    if error == nil {
                        self.fbUserLoggedInDelegate.userLoggedIn(sender: self)
                    }
                })
            }
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        UserDefaultManager.clearUserDefaults()
        FirebaseAuthManager.logoutOfFireBase()
    }
}

protocol FBUserLoggedInDelegate {
    func userLoggedIn(sender: FBLoginButtonDelegate)
}
