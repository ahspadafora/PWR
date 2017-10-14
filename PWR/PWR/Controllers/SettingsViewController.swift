//
//  SettingsViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var settingsTable: UITableView!
    @IBOutlet weak var logOutButton: UIButton!
    var usersState: State!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usersState = UserDefaultManager.storedState
        
        settingsTable.delegate = self
        settingsTable.dataSource = self
        logOutButton.contentHorizontalAlignment = .left
    }
    
    @IBAction func logOutUser(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.segueToLoginFromHome, sender: self)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: Constants.settingsTableCell)
        var currentSetting: String
        
        switch indexPath.section {
        case 0:
            currentSetting = self.usersState.title
        case 1:
            currentSetting = "Daily" // to-do: bool - check if they have set up push  notifications
        default:
            currentSetting = ""
        }
        
        cell.textLabel?.text = currentSetting
        cell.detailTextLabel?.text = "Change it?"
        cell.detailTextLabel?.textColor = UIColor.PWRred
        cell.textLabel?.font = UIFont(name: "Avenir-Roman", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Avenir-LightOblique", size: 18)
        
        cell.backgroundColor = UIColor.PWRpale
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: Constants.segueFromSettingsToStatePicker, sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segueToLoginFromHome {
            FBSDKLoginManager().logOut()
            FirebaseAuthManager.logoutOfFireBase()
            UserDefaultManager.clearUserDefaults()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Current state:"
        case 1:
            return "Remind to call?"
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
