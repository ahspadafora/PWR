//
//  ViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit
import CoreData

class StateCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    var stateFetchedResultsController: NSFetchedResultsController<NSFetchRequestResult>?
    var coredataStates: [State] = []
    
    var states: [St] = StateGetter().states
    var filteredStates: [St] = [] {
        didSet {
            self.collectionView?.reloadSections(IndexSet(integer: 1))
        }
    }
    var selectedState: St!
    var isFiltering = false
    var statePickerDelegate: StatePickerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.stateFetchedResultsController != nil {
            do {
                try self.stateFetchedResultsController!.performFetch()
//                print("fetchedresultscontroller.fetchedObjects.count = \(self.stateFetchedResultsController?.fetchedObjects?.count)")
//                guard let results = self.stateFetchedResultsController!.fetchedObjects else { return }
//                guard let firstResult: State = results[0] as? State else { return }
//                print(firstResult.senators?.allObjects)
            }
            catch let error as NSError {
                print(error.localizedDescription)
            }
        }
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
    }
}


extension StateCollectionViewController {
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
        isFiltering = (searchText.characters.count != 0)
        self.filterStatesForSearchText(searchText.lowercased())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func filterStatesForSearchText(_ searchText: String) {
        self.filteredStates = self.states.filter{$0.title.lowercased().hasPrefix(searchText.lowercased()) || $0.abbreviation.lowercased().hasPrefix(searchText.lowercased())}
    }
}

extension StateCollectionViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        guard let fetchedObjs = controller.fetchedObjects else { return }
        for obj in fetchedObjs {
            guard let state = obj as? State else { return }
            self.coredataStates.append(state)
        }
        print(coredataStates.count)
    }
    
}



