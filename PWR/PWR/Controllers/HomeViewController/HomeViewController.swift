//
//  HomeViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import CoreData

class HomeViewController: UIViewController, StatePickerDelegate {
    
    // MARK: - IBOutlets
    @IBOutlet weak var stateBannerView: BannerView!
    @IBOutlet weak var senatorTable: UITableView!
    
    // MARK: - Properties
    var usersState: St!
    var senators: [Sen] = []
    var s: [Senator] = []
    
    var state: State? {
        didSet {
            print("Users state has been set to \(state?.fullname)")
            if state != nil {
                setUpLabels(state: state!)
            }
            guard let validSenators = state?.senators else { return }
            for senator in validSenators {
                guard let validSenator = senator as? Senator else {
                    print("could get senator")
                    return
                }
                s.append(validSenator)
            }
            self.senatorTable.reloadData()
        }
    }
    
    var stateFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    
    // MARK: - Override Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUsersState()
        
        senatorTable.delegate = self
        senatorTable.dataSource = self
        
        let senatorCell = UINib(nibName: "HomeTableViewCell", bundle: .main)
        senatorTable.register(senatorCell, forCellReuseIdentifier: "senator")

        
        guard let billG = BillGetter().getBills() else {
            print("couldn't get bills")
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToSearchController {
            guard let destinationVC = segue.destination as? StateCollectionViewController else { return }
            destinationVC.statePickerDelegate = self
        } else if segue.identifier == Constants.sequeToSenatorVC {
            guard let destinationVC = segue.destination as? SenatorViewController,
                let selectedSenator = sender as? Sen else { return }
                destinationVC.senator = selectedSenator
                destinationVC.usersState = self.usersState
        }
    }
    
    // MARK: - StatePickerDelegateMethod
    func userDidSelectState() {
        fetchUsersState()
    }
    
    private func setUpLabels(state: State){
        self.stateBannerView.label.text = state.fullname
        self.stateBannerView.pic.image = UIImage(imageLiteralResourceName: state.fullname)
    }
    
    private func fetchUsersState(){
        guard let storedStateForUser = UserDefaultManager.getUsersStoredState else { return }
        self.stateFetchedResultsController = NetworkManager.shared.getStateFetchedResultsController()
        self.stateFetchedResultsController!.fetchRequest.predicate = NSPredicate(format: "fullname == %@", storedStateForUser)
        do {
            try self.stateFetchedResultsController!.performFetch()
            guard let results = self.stateFetchedResultsController?.fetchedObjects else { return }
            guard let usersState = results.first as? State else { return }
            self.state = usersState
        } catch let error as NSError {
            print(error)
        }
    }
}
