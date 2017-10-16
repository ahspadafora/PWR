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
        self.textView.text = "Gwar, often styled as GWAR, is an American heavy metal band formed in Richmond, Virginia in 1984, composed of and operated by a frequently rotating line-up of musicians, artists and filmmakers collectively known as Slave Pit Inc.. On the small-screen, the group consisted of level-headed lead singer and guitarist Josie, intelligent tambourinist Valerie, and air-headed blonde drummer Melody. Other characters included their cowardly manager Alexander Cabot III, his conniving sister Alexandra, her cat Sebastian, and muscular roadie Alan. The band later became more prominent when Merritt wrote, performed and recorded songs for the audiobook versions of Lemony Snicket's A Series of Unfortunate Events. A collection of thirteen songs based on each book and two additional tracks was released as The Tragic Treasury on October 10, 2006, to coincide with the release of the final book in the series. They are also the best-selling music artists in the United States, with 178 million certified units. In 2008, the group topped Billboard magazine's list of the all-time most successful artists; as of 2017, they hold the record for most number-one hits on the Hot 100 chart with twenty. They have received seven Grammy Awards, an Academy Award for Best Original Song Score and fifteen Ivor Novello Awards. The group was inducted into the Rock and Roll Hall of Fame in 1988, and all four main members were inducted individually from 1994 to 2015. "
        // If you don't adjust the font size programatically, iOS will override the font you set in the storyboard and make the text very small, almost illegible
        self.textView.font = UIFont(name: "Avenir-Roman", size: 16)
    }
}
