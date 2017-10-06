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
    
    var userDefaults = UserDefaults.standard
    var usersState: State? {
        didSet {
            if let _ = usersState {
                self.stateLabel.text = usersState!.title
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let state = self.userDefaults.value(forKey: "State") as? String else {
            self.stateLabel.text = "You haven't choosen a state yet"
            return
        }
        self.usersState = getStateFromString(stateName: state)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToSearchController {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.states = StateGetter().states
            destinationVC.statePickerDelegate = self
        }
    }
    
    func getState(state: State) {
        self.userDefaults.set("\(state.abbreviation)", forKey: "State")
        self.stateLabel.text = "\(state.title)"
    }
}

protocol StatePickerDelegate {
    func getState(state: State)
}

func getStateFromString(stateName: String) -> State? {
    let states = StateGetter().states
    return states.first {$0.abbreviation == stateName}
}
