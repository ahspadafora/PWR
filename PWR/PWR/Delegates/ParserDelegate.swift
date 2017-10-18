//
//  ParserDelegate.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import Foundation

class ParserDelegate: NSObject, XMLParserDelegate {
    
    private var currentString =  String()
    private var currentElement = String()
    private var object: [String: String] = [:]
    private var objArray: [[String: String]] = []
    var senators: [Sen] = []
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName != "member" {
            self.currentElement = elementName
            self.object[self.currentElement] = String()
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "member" {
            self.objArray.append(self.object)
            self.object = [:]
        }
        if elementName == self.currentElement {
            self.object[self.currentElement] = self.currentString.trimmingCharacters(in: .whitespacesAndNewlines)
            self.currentString = ""
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        print("finished parsing documnet")
        print(self.objArray.count)
        self.senators = objArray.flatMap{Sen.init(dict: $0)}
    }
}


