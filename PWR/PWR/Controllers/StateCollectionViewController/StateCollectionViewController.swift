//
//  ViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import CoreData

class StateCollectionViewController: UICollectionViewController {
    
    // MARK: - Properties
    var stateFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var coredataStates: [State] = []
    var statePickerDelegate: StatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.stateFetchedResultsController = NetworkManager.shared.getStateFetchedResultsController()
        do {
            try self.stateFetchedResultsController!.performFetch()
        }
        catch let error as NSError {
            print(error.localizedDescription)
        }
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
    }
}


extension StateCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offSets: Double = 40.0
        let widthMinusOffsets = (UIScreen.main.bounds.width) - CGFloat(offSets)
        let cellSize = CGSize(width: widthMinusOffsets/2, height: widthMinusOffsets/2)
        return cellSize
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            if kind == UICollectionElementKindSectionHeader {
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
                return headerView
            }
            return UICollectionReusableView()
        default:
            return UICollectionReusableView(frame: .zero)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize.zero
        }
        return CGSize(width: 50, height: 50)
    }
}

extension StateCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.characters.count != 0 {
            self.filterStatesForSearchText(searchText.lowercased())
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        guard let stateFetchResultsController = self.stateFetchedResultsController else { return }
        stateFetchResultsController.fetchRequest.predicate = nil
        
        do {
            try stateFetchResultsController.performFetch()
            self.collectionView?.reloadSections(IndexSet(integer: 1))
        } catch let error as NSError {
            print("error during fetch request search bar button cancelled: \(error.localizedDescription)")
        }
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        if searchText.characters.count > 0 {
            self.filterStatesForSearchText(searchText)
        }
        searchBar.resignFirstResponder()
    }
    
    func filterStatesForSearchText(_ searchText: String) {
        let namePredicit: NSPredicate = NSPredicate(format: "(fullname beginswith[c] %@) || (abbreviation beginswith[c] %@)", searchText, searchText)
        guard let fetchController = self.stateFetchedResultsController else { return }
        fetchController.fetchRequest.predicate = namePredicit
        do {
            try fetchController.performFetch()
            print(fetchController.fetchedObjects?.count)
            self.collectionView?.reloadSections(IndexSet(integer: 1))
        } catch let error as NSError {
            print("\(error.localizedDescription)")
        }
        
    }
}

extension StateCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.collectionView?.reloadSections(IndexSet(integer: 1))
    }
    
}



