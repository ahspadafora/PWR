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
    
    // MARK: -  Button action functions
    func callSenator(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        print(selectedSenator?.lastName ?? "no name")
        print(selectedSenator?.phone ?? "no phone")
    }
    
    func visitSenatorsWebsite(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        print(selectedSenator?.website ?? "no site")
    }
    
    func viewSenator(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        performSegue(withIdentifier: Constants.sequeToSenatorVC, sender: self)
    }
    
    // MARK: - Helper Functions
    
    private func setUpStateLabels(state: State){
        self.stateBannerView.label.text = state.title
        self.stateBannerView.pic.image = state.pic
    }
}

