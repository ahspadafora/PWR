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
    var senator: Senator!
    var usersState: State!
    var allowedSegues = [Constants.segueToCoSponsorshipVC, Constants.segueToCommitteeVC, Constants.segueToBillDetailVC]
    
    var votingRecord: [(bill: Bill, votedInFavor: Bool)]?
    var commitees: [String]?
    var cosponsorships: [Bill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // dummy data
        usersState = State(abbreviation: "CA", title: "California", senators: [], pic: #imageLiteral(resourceName: "Oval"))
        senator = Senator(firstName: "John", lastName: "Bailey", party: "R", state: "LA", address: "??", phone: "", website: nil, memberID: "")
        commitees = ["A","B","C","D"]
        let law = Bill(name: "A", number: "", lastAction: "")
        votingRecord = [(bill: law, votedInFavor: true), (bill: law, votedInFavor: false)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bannerView.label.text = usersState.title
        self.nameLabel.text = "\(senator.firstName) \(senator.lastName)"
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard allowedSegues.contains(identifier) else { return }
        
        switch identifier {
        case Constants.segueToCommitteeVC:
            guard let destinationVC = segue.destination as? CommiteeViewController else { return }
            
            destinationVC.cellItems = self.commitees
            destinationVC.senator = self.senator
            destinationVC.usersState = self.usersState
        case Constants.segueToCoSponsorshipVC:
            guard let destinationVC = segue.destination as? CoSponsershipViewController else { return }
            
            destinationVC.cellItems = self.cosponsorships
            destinationVC.senator = self.senator
            destinationVC.usersState = self.usersState
        case Constants.segueToBillDetailVC:
            print("bill detail segue goes here")
            // code that hands over the bill in the selected cell to the bill detail vc
        //guard let destinationVC = segue.destination as? BillDetailViewController else { return }
        default:
            return
        }
    }
    
}
