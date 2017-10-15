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
    var allowedSegues = [Constants.segueToCoSponsorshipVC, Constants.segueToCommitteeVC]
    
    var votingRecord: [(bill: Bill, votedInFavor: Bool)]?
    var commitees: [String]?
    var cosponsorships: [Bill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // dummy data
        senator = Senator(firstName: "John", lastName: "Bailey", party: "R", state: "LA", address: "??", phone: "", website: nil, memberID: "")
        commitees = ["A","B","C","D"]
        let law = Bill(name: "A", number: "", lastAction: "")
        votingRecord = [(bill: law, votedInFavor: true), (bill: law, votedInFavor: false)]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usersState = State(abbreviation: "CA", title: "California", senators: [], pic: #imageLiteral(resourceName: "Oval"))
        self.bannerView.label.text = usersState.title
        // self.nameLabel.text = "\(senator.firstName) \(senator.lastName)"
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
        //guard let destinationVC = segue.destination as? BillDetailViewController else { return }
        default:
            return
        }
    }
    
}

extension SenatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let sitsOnCommitee = self.commitees else { return 1 }
            
            if sitsOnCommitee.count <= 3 {
                return sitsOnCommitee.count
            } else {
                return 4
            }
        case 1:
            guard let cosponsoredABill = self.cosponsorships else { return 1 }
            
            if cosponsoredABill.count <= 3 {
                return cosponsoredABill.count
            } else {
                return 4
            }
        case 2:
            return self.votingRecord?.count ?? 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingOrCommitee", for: indexPath)
        
        var cellText: String = ""
        
        switch indexPath.section {
        case 0:
            guard let sitsOnCommitee = commitees else {
                cellText = "No commitees"
                cell.isUserInteractionEnabled = false
                break
            }
            
            if indexPath.row < 3 {
                cellText = sitsOnCommitee[indexPath.row]
                cell.isUserInteractionEnabled = false
            } else if indexPath.row == 3 {
                cellText = "See more..."
            }
        case 1:
            guard  let cosponsoredABill = cosponsorships else {
                cellText = "No co-sponsored bills"
                cell.isUserInteractionEnabled = false
                break
            }
            
            if indexPath.row < 3 {
                cellText = cosponsoredABill[indexPath.row].name
            } else if indexPath.row == 3 {
                cellText = "See more..."
            }
        case 2:
            guard let votedOnABill = votingRecord else {
                cellText = "No bills voted on yet"
                cell.isUserInteractionEnabled = false
                break
            }
            
            cellText = votedOnABill[indexPath.row].bill.name
            
            if votedOnABill[indexPath.row].votedInFavor {
                cell.detailTextLabel?.text = "YES"
            } else {
                cell.detailTextLabel?.text = "NO"
            }
        default:
            cellText = ""
        }
        
        cell.textLabel?.text = cellText
        
        if cell.textLabel?.text == "See more..." {
            cell.textLabel?.textColor = UIColor.PWRred
            cell.textLabel?.font = UIFont(name: "Avenir-LightOblique", size: 20)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "votingOrCommitee", for: indexPath)
        
        guard cell.textLabel?.text != "See more..." else {
            performSegue(withIdentifier: Constants.segueToBillDetailVC, sender: self)
            return
        }
        
        switch indexPath.section {
        case 0:
           performSegue(withIdentifier: Constants.segueToCommitteeVC, sender: self)
        case 1:
            performSegue(withIdentifier: Constants.segueToCoSponsorshipVC, sender: self)
        case 2:
            performSegue(withIdentifier: Constants.segueToBillDetailVC, sender: self)
        default:
            return
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Committees".uppercased()
        case 1:
            return "Co-sponsored Bills".uppercased()
        case 2:
            return "Voting Record".uppercased()
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        header.textLabel?.adjustsFontSizeToFitWidth = true
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        let footer = view as! UITableViewHeaderFooterView
        
        footer.tintColor = UIColor.PWRred
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 3.0
    }
}
