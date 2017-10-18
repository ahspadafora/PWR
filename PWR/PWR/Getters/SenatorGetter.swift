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
    
    func getSenators(url: URL) -> ([String: [Sen]]){
        let parser = XMLParser(contentsOf: url)
        let parserDelegate = ParserDelegate()
        parser?.delegate = parserDelegate
        parser?.parse()
        let senators: [Sen] = parserDelegate.senators
        var stateSenatorDictionary: [String: [Sen]] = [:]
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
