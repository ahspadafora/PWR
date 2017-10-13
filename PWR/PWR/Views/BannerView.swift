//
//  BannerView.swift
//  PWR
//
//  Created by Marty Hernandez Avedon on 10/12/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

@IBDesignable class BannerView: UIView {
    
    var label: UILabel!
    var pic: UIImageView!
    
    @IBInspectable var text: String = "" {
        didSet {
            self.label.text = text
        }
    }
    
    @IBInspectable var textColor: UIColor = UIColor.white {
        didSet {
            self.label.textColor = textColor
        }
    }
    
    @IBInspectable var textBackground: UIColor = UIColor.PWRred {
        didSet {
            self.label.backgroundColor = textColor
        }
    }
    
    @IBInspectable var picBackground: UIColor = UIColor.PWRblueLight {
        didSet {
            self.backgroundColor = textColor
        }
    }
    
    @IBInspectable var image: UIImage? = nil {
        didSet {
            self.pic.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        createViews()
        
        self.addSubview(self.pic)
        self.addSubview(self.label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        createViews()
        
        self.addSubview(self.pic)
        self.addSubview(self.label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    
        constrainViews()
        styleViews()
    }
    
    private func createViews() {
        let labelFrame = CGRect.zero
        let picFrame = CGRect.zero
        self.label = UILabel(frame: labelFrame)
        self.pic = UIImageView(frame: picFrame)
    }
    
    private func constrainViews() {
        if let superview = self.superview {
            self.translatesAutoresizingMaskIntoConstraints = false
            
            _ = [
                self.widthAnchor.constraint(equalTo: superview.widthAnchor)
                , self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
                ].map { $0.isActive = true }
        }
        
        _ = [
            self.label
            , self.pic
        ].map { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        _ = [
            self.label.widthAnchor.constraint(equalToConstant: 180)
            , self.label.heightAnchor.constraint(equalToConstant: 40)
            , self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor)
            , self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor)
            , self.pic.widthAnchor.constraint(equalTo: self.heightAnchor)
            , self.pic.heightAnchor.constraint(equalTo: self.pic.widthAnchor)
            , self.pic.centerXAnchor.constraint(equalTo: self.centerXAnchor)
            , self.pic.topAnchor.constraint(equalTo: self.topAnchor)
            ].map { $0.isActive = true }
    }
    
    private func styleViews() {
        self.backgroundColor = UIColor.PWRblueLight
        self.label.backgroundColor = UIColor.PWRred
        self.pic.backgroundColor = UIColor.PWRblueLight
        
        self.label.textColor = UIColor.white
        self.label.textAlignment = .center
        self.label.font = UIFont(name: "Avenir-BlackOblique", size: 20)
        
        self.pic.contentMode = .scaleAspectFit
        self.pic.backgroundColor = UIColor.PWRblueLight
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()

        styleViews()
    }
    
}
