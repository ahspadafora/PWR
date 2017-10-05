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
    
    func getSenators(url: URL) -> ([Senator], [String: [Senator]]){
        let parser = XMLParser(contentsOf: url)
        let parserDelegate = ParserDelegate()
        parser?.delegate = parserDelegate
        parser?.parse()
        let senators: [Senator] = parserDelegate.senators
        var stateSenatorMap: [String: [Senator]] = [:]
        for senator in senators {
            if let _ = stateSenatorMap[senator.state] {
                stateSenatorMap[senator.state]?.append(senator)
            } else {
                stateSenatorMap[senator.state] = [senator]
            }
        }
        return (senators, stateSenatorMap)
    }
}
