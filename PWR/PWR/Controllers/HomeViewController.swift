//
//  HomeViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StatePickerDelegate {
    
    @IBOutlet weak var stateLabel: UILabel!
    
    var usersState: State! {
        didSet {
            self.stateLabel.text = usersState.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let state = UserDefaultManager.storedState {
            self.usersState = state
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToSearchController {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = self
        }
    }
    
    // Mark: StatePickerDelegateMethod
    func userDidSelectState() {
        guard let state = UserDefaultManager.storedState else {
            self.stateLabel.text = "You have not chosen a state"
            return
        }
        self.usersState = state
    }
    
    
}

