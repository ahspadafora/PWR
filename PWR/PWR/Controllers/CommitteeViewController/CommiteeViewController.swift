//
//  CommiteeViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class CommiteeViewController: UIViewController {

    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // Properties
    
    var senatorName: String!
    var stateName: String!
    var cellItems: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bannerView.label.text = self.stateName
        self.nameLabel.text = self.senatorName
    }
}
