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
    
    var senator: Senator!
    var usersState: State!
    var cellItems: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView.label.text = self.usersState.title
        nameLabel.text = "\(self.senator.firstName) \(self.senator.lastName)"
    }
}
