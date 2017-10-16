//
//  HomeViewControllerTableProtocolMethods.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, HomeCellButtonDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senator", for: indexPath) as! HomeTableViewCell
        
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senator", for: indexPath) as! HomeTableViewCell

        // Configure the cell...
        cell.delegate = self
        cell.configureButtons(with: indexPath)
        cell.name.text = "Sen. \(self.senators[indexPath.row].lastName)"
        cell.pic.image = #imageLiteral(resourceName: "California")
        cell.party.text = "Party: \(self.senators[indexPath.row].party)"

        return cell
    }
    
    // MARK: - Cell Delegate Method
    
    func callSegue(from button: CellButton) {
        guard let indexPath = button.positionInTable else { return }
        
        switch button.tag {
        case 0:
            print("0")
           self.viewSenator(indexPath)
        case 1:
            print("1")
           self.callSenator(indexPath)
        case 2:
            print("2")
           self.visitSenatorsWebsite(indexPath)
        default:
            return
        }
    }
    
    // MARK: Button Actions

    func callSenator(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        print(selectedSenator?.lastName ?? "no name")
        print(selectedSenator?.phone ?? "no phone")
    }
    
    func visitSenatorsWebsite(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        print(selectedSenator?.website ?? "no site")
    }
    
    func viewSenator(_ indexPath: IndexPath) {
        self.selectedSenator = self.senators[indexPath.row]
        performSegue(withIdentifier: Constants.sequeToSenatorVC, sender: self)
    }
}
