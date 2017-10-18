//
//  LoginViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController, StatePickerDelegate, FBUserLoggedInDelegate {
    
    var fbButtonDelegate: FBLoginButtonDelegate!
    var stateFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fbButtonDelegate = FBLoginButtonDelegate(fbDelegate: self)
        setUpFacebookBttn()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueFromLoginToStateVC {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            guard let fetchedResultsController = self.stateFetchedResultsController else { return }
            destinationVC.stateFetchedResultsController = fetchedResultsController
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


