//
//  StyleManager.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/10/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

protocol ThemeUIKitClasses {
   func applyStylingAppwide()
}

class StyleManager: ThemeUIKitClasses {
    private init() {}
    static let instance = StyleManager()
    
   private func createFontDirectory() -> [String: UIFont] {
        let bold = "Avenir-Black"
        let boldItalic = "Avenir-BlackOblique"
        let regular = "Avenir-Roman"
        let italic = "Avenir-Oblique"
        let light = "Avenir-Light"
        let lightItalic = "Avenir-LightOblique"
        
        let fontDirectory = [
            "bold": UIFont(name: bold, size: 20)!
            , "bold italic": UIFont(name: boldItalic, size: 20)!
            , "regular": UIFont(name: regular, size: 20)!
            , "italic": UIFont(name: italic, size: 20)!
            , "light": UIFont(name: light, size: 20)!
            , "light italic": UIFont(name: lightItalic, size: 20)!
        ]
        
        return fontDirectory
    }
    
    func applyStylingAppwide() {
        // this function automatically styles many UIKit classes
        
        let themeFonts = self.createFontDirectory()
        
        // top bar
        
        let proxyNavBar = UINavigationBar.appearance()
        
        // texty views

        let proxyTextField = UITextField.appearance()
        let proxyTextView = UITextView.appearance()
        let proxyPlaceholder = UILabel.appearance(whenContainedInInstancesOf: [UITextField.self])
        let proxyButtonLabel = UILabel.appearance(whenContainedInInstancesOf: [UIButton.self])
        
        // table & collection views
        
        let proxyActivityIndicator = UIActivityIndicatorView.appearance()
        let proxyWebView = UIWebView.appearance()
        let proxyTableView = UITableView.appearance()
      //  let proxyTableCell = UITableViewCell.appearance()
        let proxySectionHeader = UITableViewHeaderFooterView.appearance()
        let proxyCollectionView = UICollectionView.appearance()
     //   let proxyCollectionViewCell = UICollectionViewCell.appearance()
     //   let proxyScrollView = UIScrollView.appearance()
        
        // styling
        
        let navTitleColor = UIColor.PWRred
        let navTitleFont = themeFonts["bold"]!
        let navAttributes: [String: AnyObject] = [
            NSFontAttributeName: navTitleFont,
            NSForegroundColorAttributeName: navTitleColor
        ]
        
        proxyNavBar.tintColor = UIColor.PWRred
        proxyNavBar.titleTextAttributes = navAttributes
        proxyNavBar.barTintColor = UIColor.PWRpale
        proxyNavBar.backgroundColor = UIColor.PWRred
        
        proxyTextField.backgroundColor = UIColor.white
        proxyTextField.textColor = UIColor.black
        proxyTextField.font = themeFonts["regular"]
        
        proxyPlaceholder.textColor = UIColor.lightGray
        
        proxyActivityIndicator.color = UIColor.PWRred
        proxyActivityIndicator.hidesWhenStopped = true
        proxyActivityIndicator.activityIndicatorViewStyle = .whiteLarge
        
        proxyTextView.backgroundColor = UIColor.PWRpale
        proxyTextView.textColor = UIColor.black
        proxyTextView.font = themeFonts["reguar"]
        
        proxyButtonLabel.textColor = UIColor.white
        proxyButtonLabel.font = themeFonts["bold"]
        
        proxyWebView.scalesPageToFit = true
        proxyWebView.scrollView.bounces = true
        proxyWebView.layer.cornerRadius = 3.0
        proxyWebView.layer.borderWidth = 1.0
        
        proxyTableView.backgroundColor = UIColor.PWRpale
        proxyTableView.separatorColor = UIColor.PWRred
        
        proxyCollectionView.backgroundColor = UIColor.PWRpale
        
        proxySectionHeader.textLabel?.textColor = UIColor.PWRpale
        proxySectionHeader.textLabel?.backgroundColor = UIColor.PWRred
        proxySectionHeader.textLabel?.font = themeFonts["bold"]
        
    }
    
}
