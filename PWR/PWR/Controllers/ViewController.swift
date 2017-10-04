//
//  ViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var parserDelegate: ParserDelegate!
    var senators: [Senator] = [] {
        didSet{
            print(senators.count)
            print("First Name: \(senators[0].firstName) Last Name: \(senators[0].lastName) Party: \(senators[0].party) website: \(senators[0].website?.url)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parserDelegate = ParserDelegate()
        if let path = getXmlUrl() {
            DataManager.shared.parser = XMLParser(contentsOf: path)
            DataManager.shared.parser!.delegate = self.parserDelegate
            DataManager.shared.getData()
            self.senators = self.parserDelegate.senators
        }
    }
}

func getXmlUrl() -> URL?{
    if let path = Bundle.main.url(forResource: "senators", withExtension: "xml") {
        return path
    } else {
        return nil
    }
}

