//
//  SenatorGetter.swift
//  PWR
//
//  Created by Amber Spadafora on 10/5/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class SenatorGetter {
    init(){}
    
    func getSenatorXMLUrl() -> URL?{
        if let path = Bundle.main.url(forResource: "senators", withExtension: "xml") {
            return path
        } else {
            return nil
        }
    }
    
    func getSenators(url: URL) -> ([String: [Senator]]){
        let parser = XMLParser(contentsOf: url)
        let parserDelegate = ParserDelegate()
        parser?.delegate = parserDelegate
        parser?.parse()
        let senators: [Senator] = parserDelegate.senators
        var stateSenatorDictionary: [String: [Senator]] = [:]
        for senator in senators {
            if let _ = stateSenatorDictionary[senator.state] {
                stateSenatorDictionary[senator.state]?.append(senator)
            } else {
                stateSenatorDictionary[senator.state] = [senator]
            }
        }
        return (stateSenatorDictionary)
    }
}
