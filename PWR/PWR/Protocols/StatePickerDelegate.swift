//
//  StatePickerDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

protocol StatePickerDelegate {
    func userDidSelectState()
}

/*
 This protocol is for the StateCollectionVC, so that we can pass the selected state from the StateCollectionVC to any other object that conforms to the StatePickerDelegate
 */
