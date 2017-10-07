//
//  StateGetter.swift
//  PWR
//
//  Created by Amber Spadafora on 10/5/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

struct StateGetter {
    var states: [State] {
        if let states = getStates() {
            return states.sorted { $0.title < $1.title }
        } else {
            return []
        }
    }
    
    private func getStates() -> [State]? {
        if let url = SenatorGetter().getSenatorXMLUrl() {
            let senatorMap = SenatorGetter().getSenators(url: url)
            let statesDict = States.stateDictionary // [abbreviation: fullName]
            var states:[State] = []
            for (key, value) in statesDict {
                let senators = senatorMap[key] ?? []
                let map = UIImage(named: value) ?? UIImage(imageLiteralResourceName: "Oval")
                let state = State(abbreviation: key, title: value, senators: senators, pic: map)
                states.append(state)
            }
            return states
        } else {
            return nil
        }
    }
}
