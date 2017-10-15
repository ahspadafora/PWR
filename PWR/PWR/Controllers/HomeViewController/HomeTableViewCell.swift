//
//  HomeTableViewCell.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

// working off of advice here: https://stackoverflow.com/questions/26880526/performing-a-segue-from-a-button-within-a-custom-uitableviewcell

protocol AllowSegueFromCellButton {
    func callSegue(from button: UIButton)
}

class HomeTableViewCell: UITableViewCell {

    // display
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var party: UILabel!
    
    // end-user interactive
    @IBOutlet weak var senatorButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var webButton: UIButton!

    // properties
    
    var delegate: AllowSegueFromCellButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pic.layer.cornerRadius = pic.frame.width/2
        pic.layer.borderColor = UIColor.PWRblueDark.cgColor
        pic.layer.borderWidth = 3
        pic.clipsToBounds = true
        
        self.senatorButton.addTarget(self, action: #selector(senatorButtonWasTapped(sender:)), for: .touchUpInside)
        self.callButton.addTarget(self, action: #selector(callButtonWasTapped(sender:)), for: .touchUpInside)
        self.webButton.addTarget(self, action: #selector(webButtonWasTapped(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func senatorButtonWasTapped(sender: UIButton) {
        guard let setDelegate = self.delegate else { return }
        
        setDelegate.callSegue(from: sender)
    }
    
    func callButtonWasTapped(sender: UIButton) {}
    
    func webButtonWasTapped(sender: UIButton) {}
}
