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
    
    // Properties
    
    var commitees: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        bannerView.label.text = ""
    }
}

extension CommiteeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitees?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bill", for: indexPath)
        
        cell.textLabel?.text = commitees[indexPath.row]
        
        return cell
    }
}
