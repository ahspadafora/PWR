//
//  HomeTableViewCell.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/13/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

// working off of advice here: https://stackoverflow.com/questions/26880526/performing-a-segue-from-a-button-within-a-custom-uitableviewcell

protocol HomeCellButtonDelegate {
    func callSegue(from button: CellButton)
}

class HomeTableViewCell: UITableViewCell {

    // display
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var party: UILabel!
    
    // end-user interactive
    @IBOutlet weak var senatorButton: CellButton!
    @IBOutlet weak var callButton: CellButton!
    @IBOutlet weak var webButton: CellButton!

    // properties
    var delegate: HomeCellButtonDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        pic.layer.cornerRadius = pic.frame.width/2
        pic.layer.borderColor = UIColor.PWRblueDark.cgColor
        pic.layer.borderWidth = 3
        pic.clipsToBounds = true
        
        self.senatorButton.addTarget(self, action: #selector(self.cellButtonWasTapped(sender:)), for: .touchUpInside)
        self.callButton.addTarget(self, action: #selector(self.cellButtonWasTapped(sender:)), for: .touchUpInside)
        self.webButton.addTarget(self, action: #selector(self.cellButtonWasTapped(sender:)), for: .touchUpInside)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureButtons(with indexPath: IndexPath) {
        _ = [
            self.senatorButton,
            self.callButton,
            self.webButton
        ].map { $0.positionInTable = indexPath }
    }
    
    func cellButtonWasTapped(sender: CellButton) {
        guard let setDelegate = self.delegate else { return }
        
        setDelegate.callSegue(from: sender)
    }
}
