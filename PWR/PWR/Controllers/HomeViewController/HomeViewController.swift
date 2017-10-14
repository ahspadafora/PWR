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
    @IBOutlet weak var senatorTable: UITableView!
    
    // MARK: - Properties
    var usersState: State!
    var senators: [Senator] = []
    var selectedSenator: Senator?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        senatorTable.delegate = self
        senatorTable.dataSource = self
        
        let senatorCell = UINib(nibName: "HomeTableViewCell", bundle: .main)
        
        senatorTable.register(senatorCell, forCellReuseIdentifier: "senator")
        
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
        } else if segue.identifier == Constants.sequeToSenatorVC {
            guard let destinationVC = segue.destination as? SenatorViewController,
                let selectedSenator = self.selectedSenator else { return }
                destinationVC.senator = selectedSenator
                destinationVC.usersState = self.usersState
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
        selectedSenator = self.senators[sender.tag]
        print(selectedSenator?.lastName ?? "no name")
        print(selectedSenator?.phone ?? "no phone")
    }
    
    @IBAction func visitSenatorsWebsite(_ sender: UIButton) {
        selectedSenator = self.senators[sender.tag]
        print(selectedSenator?.website ?? "no site")
    }
    
    @IBAction func viewSenator(_ sender: UIButton) {
        selectedSenator = self.senators[sender.tag]
        performSegue(withIdentifier: Constants.sequeToSenatorVC, sender: self)
    }
    
    // MARK: - Helper Functions
    private func setUpSenatorLabels(senators: [Senator]){
//        self.firstSenPartyLabel.text = "Party: \(senators[0].party)\nOffices located at \(senators[0].address)"
//        self.firstSenatorNameLabel.text = "Sen. \(senators[0].lastName)"
//        self.secondSenPartyLabel.text = "Party: \(senators[1].party)\nOffices located at \(senators[1].address)"
//        self.secondSenNameLabel.text = "Sen. \(senators[1].lastName)"
    }
    
    private func setUpStateLabels(state: State){
        self.stateBannerView.label.text = state.title
        self.stateBannerView.pic.image = state.pic
    }
}

