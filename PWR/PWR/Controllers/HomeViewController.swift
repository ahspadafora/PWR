//
//  HomeViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, StatePickerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var stateImageView: UIImageView!
    @IBOutlet weak var firstSenatorNameLabel: UILabel!
    @IBOutlet weak var firstSenPartyLabel: UILabel!
    @IBOutlet weak var secondSenNameLabel: UILabel!
    @IBOutlet weak var secondSenPartyLabel: UILabel!
    
    // MARK: - Properties
    var usersState: State!
    var senators: [Senator] = []
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        if let state = UserDefaultManager.storedState {
            self.usersState = state
            self.senators = self.usersState.senators
            setUpSenatorLabels(senators: self.senators)
            setUpStateLabels(state: self.usersState)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToSearchController {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = self
        }
    }
    
    // MARK: - StatePickerDelegateMethod
    func userDidSelectState() {
        guard let state = UserDefaultManager.storedState else {
            self.stateLabel.text = "You have not chosen a state"
            return
        }
        self.usersState = state
    }
    
    // MARK: -  IBAction functions
    @IBAction func callSenator(_ sender: UIButton) {
        // switch on senator
    }
    
    @IBAction func visitSenatorsWebsite(_ sender: UIButton) {
        // switch on senator
    }
    
    // MARK: - Helper Functions
    private func setUpSenatorLabels(senators: [Senator]){
        self.firstSenPartyLabel.text = "Party: \(senators[0].party)"
        self.firstSenatorNameLabel.text = "Senator \(senators[0].lastName)"
        self.secondSenPartyLabel.text = "Party: \(senators[1].party)"
        self.secondSenNameLabel.text = "Senator \(senators[1].lastName)"
    }
    
    private func setUpStateLabels(state: State){
        self.stateLabel.text = state.title
        self.stateImageView.image = state.pic
    }
    
    
    
}

