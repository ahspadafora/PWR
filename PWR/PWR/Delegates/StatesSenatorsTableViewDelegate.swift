//
//  StatesSenatorsTableViewDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation
import UIKit

class StatesSenatorsTableViewDelegate: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    
}
