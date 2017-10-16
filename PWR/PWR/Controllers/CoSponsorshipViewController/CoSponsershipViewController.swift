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
    
    var senator: Senator!
    var usersState: State!
    var cellItems: [Bill]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView.label.text = self.usersState.title
        nameLabel.text = "\(self.senator.firstName) \(self.senator.lastName)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else { return }
        guard identifier == Constants.segueToBillDetailVC else { return }
        
        // code that hands over the bill in the selected cell to the bill detail vc
    }
}
