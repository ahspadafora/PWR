//
//  Website.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class Website {
    var url: String
    unowned let senator: Senator
    init(url: String, senator: Senator) {
        self.url = url
        self.senator = senator
    }
}
