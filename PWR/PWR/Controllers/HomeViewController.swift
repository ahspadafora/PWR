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
    @IBOutlet weak var stateBannerView: BannerView!
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
            self.stateBannerView.label.text = "You have not chosen a state"
            return
        }
        self.usersState = state
    }
    
    // MARK: -  IBAction functions
    @IBAction func callSenator(_ sender: UIButton) {
        let selectedSenator = self.senators[sender.tag]
        print(selectedSenator.lastName)
        print(selectedSenator.phone)
    }
    
    @IBAction func visitSenatorsWebsite(_ sender: UIButton) {
        let selectedSenator = self.senators[sender.tag]
        print(selectedSenator.website)
    }
    
    // MARK: - Helper Functions
    private func setUpSenatorLabels(senators: [Senator]){
        self.firstSenPartyLabel.text = "Party: \(senators[0].party)\nOffices located at \(senators[0].address)"
        self.firstSenatorNameLabel.text = "Sen. \(senators[0].lastName)"
        self.secondSenPartyLabel.text = "Party: \(senators[1].party)\nOffices located at \(senators[1].address)"
        self.secondSenNameLabel.text = "Sen. \(senators[1].lastName)"
    }
    
    private func setUpStateLabels(state: State){
        self.stateBannerView.label.text = state.title
        self.stateBannerView.pic.image = state.pic
    }
}

