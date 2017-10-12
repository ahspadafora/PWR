//
//  Bill.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/11/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

struct Bill {
    let name: String
    let number: String
    var billID: String {
        return number.components(separatedBy: ".").joined().lowercased() + "-115"
    }
    let lastAction: String
}
