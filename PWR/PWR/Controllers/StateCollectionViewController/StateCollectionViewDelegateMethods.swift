//
//  StateCollectionViewDelegateMethods.swift
//  PWR
//
//  Created by Amber Spadafora on 10/6/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

extension StateCollectionViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            if isFiltering {
                return filteredStates.count
            } else {
                return states.count
            }
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "state", for: indexPath) as! StateCollectionViewCell
            switch isFiltering {
            case true:
                let tintedImage = self.filteredStates[indexPath.row].pic.withRenderingMode(.alwaysTemplate)
                cell.stateLabel.text = self.filteredStates[indexPath.row].abbreviation
                cell.pictureView.image = tintedImage
            case false:
                let tintedImage = self.states[indexPath.row].pic.withRenderingMode(.alwaysTemplate)
                cell.stateLabel.text = self.states[indexPath.row].abbreviation
                cell.pictureView.image = tintedImage
            }
            
            cell.pictureView.tintColor = UIColor.white
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        switch isFiltering {
        case true:
            self.selectedState = self.filteredStates[indexPath.row]
        default:
            self.selectedState = self.states[indexPath.row]
        }
        UserDefaultManager.setStoredState(abbreviation: self.selectedState.abbreviation)
        self.statePickerDelegate?.userDidSelectState()
        performSegue(withIdentifier: Constants.segueFromStateCollectionVCtoHomeVC, sender: self)
    }
    
    
}
