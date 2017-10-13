//
//  SenatorViewController.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/11/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class SenatorViewController: UIViewController {

    @IBOutlet weak var senatorBannerView: BannerView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var partyLabel: UILabel!
    @IBOutlet weak var senatorTable: UITableView!
    
    // properties
    var senator: Senator!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
