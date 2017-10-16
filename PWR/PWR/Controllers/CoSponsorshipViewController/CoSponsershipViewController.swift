//
//  CoSponsershipViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class CoSponsershipViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // Properties
    
    var senatorName: String!
    var stateName: String!
    var cellItems: [Bill]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bannerView.label.text = self.stateName
        self.nameLabel.text = self.senatorName
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier,
            identifier == Constants.segueToBillDetailVC,
            let destinationVC = segue.destination as? BillDetailViewController,
            let bill = sender as? Bill else { return }
        
        destinationVC.bill = bill
    }
}
