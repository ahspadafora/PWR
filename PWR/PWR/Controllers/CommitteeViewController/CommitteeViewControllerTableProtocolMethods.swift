//
//  CommitteeViewControllerTableProtocolMethods.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/15/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

extension CommiteeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellItems?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "committee", for: indexPath)
        
        cell.textLabel?.text = cellItems[indexPath.row]
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Commitees".uppercased()
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Avenir-Light", size: 20)
        header.textLabel?.adjustsFontSizeToFitWidth = true
    }
}
