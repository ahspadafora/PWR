//
//  SenatorViewController.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/11/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class SenatorViewController: UIViewController {
    
    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // properties
    var senator: Sen!
    var usersState: St!
    var allowedSegues = [Constants.segueToCoSponsorshipVC, Constants.segueToCommitteeVC, Constants.segueToBillDetailVC]
    
    var votingRecord: [(bill: Bill, votedInFavor: Bool)]?
    var commitees: [String]?
    var cosponsorships: [Bill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dummy data
        
        self.commitees = ["A","B","C","D"]
        let law = Bill(name: "A", number: "", lastAction: "")
        self.cosponsorships = [law, law, law, law]
        self.votingRecord = [(bill: law, votedInFavor: true), (bill: law, votedInFavor: false)]
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bannerView.label.text = usersState.title
        self.nameLabel.text = "\(senator.firstName) \(senator.lastName)"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        allowedSegues.contains(identifier) else { return }
        
        switch identifier {
        case Constants.segueToCommitteeVC:
            guard let destinationVC = segue.destination as? CommiteeViewController else { return }
            
            destinationVC.cellItems = self.commitees
            destinationVC.senatorName = "\(self.senator.firstName) \(self.senator.lastName)"
            destinationVC.stateName = self.usersState.title
        case Constants.segueToCoSponsorshipVC:
            guard let destinationVC = segue.destination as? CoSponsershipViewController else { return }
            
            destinationVC.cellItems = self.cosponsorships
            destinationVC.senatorName = "\(self.senator.firstName) \(self.senator.lastName)"
            destinationVC.stateName = self.usersState.title
        case Constants.segueToBillDetailVC:
            guard let identifier = segue.identifier,
                identifier == Constants.segueToBillDetailVC,
                let destinationVC = segue.destination as? BillDetailViewController,
                let bill = sender as? Bill else { return }
            
            destinationVC.bill = bill
        default:
            return
        }
    }
    
}
