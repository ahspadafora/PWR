//
//  LoginViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, StatePickerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        signIn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromLoginToStateVC {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = HomeViewController()
        }
    }

    func signIn(){
        let dummyId = "123456"
        // add firebase authentication
        UserDefaultManager.setisLoggedInTo(bool: true)
        UserDefaultManager.setUserId(uid: dummyId)
        if let _ = UserDefaultManager.storedState {
            goToHome()
        } else {
            goToStatePicker()
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

}
