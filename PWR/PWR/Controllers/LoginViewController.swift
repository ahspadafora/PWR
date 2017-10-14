//
//  LoginViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, StatePickerDelegate, FBUserLoggedInDelegate {
    
    var fbButtonDelegate: FBLoginButtonDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbButtonDelegate = FBLoginButtonDelegate(fbDelegate: self)
        setUpFacebookBttn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromLoginToStateVC {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = HomeViewController()
        }
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
        let loginButton = self.fbButtonDelegate.fbButton
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)
    }
    
    func userLoggedIn(sender: FBLoginButtonDelegate) {
        if let _ = UserDefaultManager.storedState {
            goToHome()
        } else {
            goToStatePicker()
        }
    }
}


