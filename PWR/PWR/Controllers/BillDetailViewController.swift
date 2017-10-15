//
//  BillDetailViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class BillDetailViewController: UIViewController {
    
    @IBOutlet weak var bannerView: BannerView!
    @IBOutlet weak var textView: UITextView!
    
    // Properties
    
    var bill: Bill!

    override func viewDidLoad() {
        super.viewDidLoad()
   }
    
    override func viewWillAppear(_ animated: Bool) {
        self.bannerView.label.text = bill.name
        // need a bill summary in the bill model
        self.textView.text = ""
    }
}
