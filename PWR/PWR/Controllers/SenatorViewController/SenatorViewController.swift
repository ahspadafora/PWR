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
    var senatorCD: Senator?
    var senatorsState: State?
    
    var allowedSegues = [Constants.segueToCoSponsorshipVC, Constants.segueToCommitteeVC, Constants.segueToBillDetailVC]
    
    var votingRecord: [(bill: Bill, votedInFavor: Bool)]?
    var commitees: [String]?
    var cosponsorships: [Bill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let firstname = senatorCD?.firstName, let lastname = senatorCD?.lastName, let state = self.senatorsState else { return }
        self.bannerView.label.text = state.fullname
        self.nameLabel.text = "\(firstname) \(lastname)"
        
        
        self.commitees = ["A","B","C","D"]
        let law = Bill(name: "A", number: "", lastAction: "")
        self.cosponsorships = [law, law, law, law]
        self.votingRecord = [(bill: law, votedInFavor: true), (bill: law, votedInFavor: false)]
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
        allowedSegues.contains(identifier) else { return }
        guard let state = self.senatorsState, let firstname = senatorCD?.firstName, let lastname = senatorCD?.lastName else { return }
        
        switch identifier {
        case Constants.segueToCommitteeVC:
            guard let destinationVC = segue.destination as? CommiteeViewController else { return }
            
            destinationVC.cellItems = self.commitees
            destinationVC.senatorName = "\(firstname) \(lastname)"
            destinationVC.stateName = state.fullname
            
        case Constants.segueToCoSponsorshipVC:
            
            guard let destinationVC = segue.destination as? CoSponsershipViewController else { return }
            destinationVC.cellItems = self.cosponsorships
            destinationVC.senatorName = "\(firstname) \(lastname)"
            destinationVC.stateName = state.fullname
            
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
