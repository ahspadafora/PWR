//
//  LoginViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FirebaseAuth

class LoginViewController: UIViewController, StatePickerDelegate, FBSDKLoginButtonDelegate {
    
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if error != nil {
                print(error?.localizedDescription)
            }
            guard let uid = user?.uid else { return }
            self.signIn(uid: uid)
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        UserDefaultManager.clearUserDefaults()
        let auth = Auth.auth()
        do {
            try auth.signOut()
        }
        catch let signoutError as NSError {
            print(signoutError.localizedDescription)
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpFacebookBttn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromLoginToStateVC {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = HomeViewController()
        }
    }

    func signIn(uid: String){
        UserDefaultManager.setisLoggedInTo(bool: true)
        UserDefaultManager.setUserId(uid: uid)
        goToStatePicker()
    }
    func goToHome(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.segueFromLoginToHomeVC, sender: self)
        }
    }
    func goToStatePicker(){
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constants.segueFromLoginToStateVC, sender: self)
        }
    }
    
    func userDidSelectState() {
        goToHome()
    }
    func setUpFacebookBttn(){
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
}
