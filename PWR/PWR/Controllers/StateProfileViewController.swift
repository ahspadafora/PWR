//
//  StateProfileViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/4/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class StateProfileViewController: UIViewController {

    var state: State!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.state.title)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
