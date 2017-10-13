//
//  HomeTableViewCell.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var party: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pic.layer.cornerRadius = pic.frame.width/2
        pic.layer.borderColor = UIColor.PWRblueDark.cgColor
        pic.layer.borderWidth = 3
        pic.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
