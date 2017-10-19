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
            guard let stateFetchedResultsController = self.stateFetchedResultsController,
                let fetchedObjects = stateFetchedResultsController.fetchedObjects else { return 0 }
            return fetchedObjects.count
        } else {
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "state", for: indexPath) as! StateCollectionViewCell

            guard let stateResults = self.stateFetchedResultsController else { return cell }
            
            // our collection view has only one section with coreData so our fetchedResultsController has only one section
            let ipForCell = IndexPath(row: indexPath.row, section: 0)
            guard let stateForCell = stateResults.object(at: ipForCell) as? State else { return cell }
            let imageForCell = UIImage(imageLiteralResourceName: stateForCell.fullname).withRenderingMode(.alwaysTemplate)
            cell.pictureView.tintColor = UIColor.white
            cell.pictureView.image = imageForCell
            cell.stateLabel.text = stateForCell.fullname
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let ip = IndexPath(row: indexPath.row, section: 0)
        guard let stateObj = self.stateFetchedResultsController?.object(at: ip) as? State else { return }
        UserDefaultManager.setUsersState(stateName: stateObj.fullname)
        self.statePickerDelegate?.userDidSelectState()
        performSegue(withIdentifier: Constants.segueFromStateCollectionVCtoHomeVC, sender: self)
    }
    
    
}
