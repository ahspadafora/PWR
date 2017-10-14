//
//  SenatorViewController.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/11/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class SenatorViewController: UIViewController {

    @IBOutlet weak var senatorBannerView: BannerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var senatorTable: UITableView!
    
    // properties
    var senator: Senator!
    var usersState: State!
    
    var votingRecord: [(bill: Bill, votedInFavor: Bool)]?
    var commitees: [String]?
    var cosponsorships: [Bill]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commitees = ["A","B","C","D"]
        let law = Bill(name: "A", number: "", lastAction: "")
        votingRecord = [(bill: law, votedInFavor: true), (bill: law, votedInFavor: false)]
        senatorTable.delegate = self
        senatorTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        usersState = State(abbreviation: "CA", title: "California", senators: [], pic: #imageLiteral(resourceName: "Oval"))
        self.senatorBannerView.label.text = usersState.title
       // self.nameLabel.text = "\(senator.firstName) \(senator.lastName)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SenatorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            guard let sitsOnCommitee = self.commitees else {
                return 1
            }
            
            if sitsOnCommitee.count <= 3 {
                return sitsOnCommitee.count
            } else {
                return 4
            }
        case 1:
            guard let cosponsoredABill = self.cosponsorships else {
                return 1
            }
            
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
        let cell = senatorTable.dequeueReusableCell(withIdentifier: "votingOrCommitee", for: indexPath)
        
        var cellText: String = ""
        
        switch indexPath.section {
        case 0:
            if let sitsOnCommitee = commitees {
                if indexPath.row < 3 {
                    cellText = sitsOnCommitee[indexPath.row]
                } else if indexPath.row == 3 {
                    cellText = "See more..."
                }
            } else  {
                cellText = "No commitees"
            }
        case 1:
            if let cosponsoredABill = cosponsorships {
                if indexPath.row < 3 {
                    cellText = cosponsoredABill[indexPath.row].name
                } else if indexPath.row == 3 {
                    cellText = "See more..."
                }
            } else {
                cellText = "No co-sponsored bills"
            }
        case 2:
            if let votedOnABill = votingRecord {
                cellText = votedOnABill[indexPath.row].bill.name
                if votedOnABill[indexPath.row].votedInFavor {
                    cell.detailTextLabel?.text = "YES"
                } else {
                    cell.detailTextLabel?.text = "NO"
                }
            } else {
                cellText = "No bills voted on yet"
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
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Commitees".uppercased()
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
