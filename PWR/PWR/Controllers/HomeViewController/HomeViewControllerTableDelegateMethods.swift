//
//  HomeViewControllerTableProtocolMethods.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

extension HomeViewController: UITableViewDelegate, UITableViewDataSource, HomeCellButtonDelegate {

    // MARK: - Table view data source
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.senators.count
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "senator", for: indexPath) as! HomeTableViewCell

        // Configure the cell...
        cell.delegate = self
        cell.configureButtons(with: indexPath)
        cell.senator = senators[indexPath.row]
        return cell
    }
    
    // MARK: - Cell Delegate Method
    
    func callSegue(from button: CellButton) {
        guard let indexPath = button.positionInTable else { return }
        let selectedSenator = self.senators[indexPath.row]
        
        switch button.tag {
        case 0:
            print("0")
            self.viewSenator(selectedSenator)
        case 1:
            print("1")
            self.callSenator(selectedSenator)
        case 2:
            print("2")
            self.visitSenatorsWebsite(selectedSenator)
        default:
            return
        }
    }
    
    // MARK: Button Actions

    func callSenator(_ senator: Senator) {
        print(senator.lastName)
        print(senator.phoneNumber)
    }
    
    func visitSenatorsWebsite(_ senator: Senator) {
        print(senator.contactUrl ?? "no site")
    }
    
    func viewSenator(_ senator: Senator) {
        performSegue(withIdentifier: Constants.sequeToSenatorVC, sender: senator)
    }
}
