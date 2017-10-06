//
//  ViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class StateCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    var states: [State] = StateGetter().states.sorted { $0.title < $1.title }
    var filteredStates: [State] = [] {
        didSet {
            self.collectionView?.reloadSections(IndexSet(integer: 1))
        }
    }
    var selectedState: State!
    
    
    //var senatorStateMap: [String: [Senator]]!
    var isFiltering = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpCollectionView()
    }
    
    // MARK: Helper Functions
    
    private func setUpCollectionView(){
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.view.backgroundColor = UIColor.white
    }
    
    func filterStatesForSearchText(_ searchText: String) {
        self.filteredStates = self.states.filter{$0.title.lowercased().hasPrefix(searchText.lowercased())}
    }
    
}


extension StateCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offSets: Double = 40.0
        
        let widthMinusOffsets = (UIScreen.main.bounds.width) - CGFloat(offSets)
        let cellSize = CGSize(width: widthMinusOffsets/2, height: widthMinusOffsets/2)
        return cellSize
    }
}

extension StateCollectionViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 1:
            if isFiltering {
                return filteredStates.count
            } else {
                return states.count
            }
        default:
            return 0
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 1 {
            let cell = self.collectionView?.dequeueReusableCell(withReuseIdentifier: "state", for: indexPath) as! StateCollectionViewCell
            
            print("is filtering is set to : \(isFiltering)")
            switch isFiltering {
            case true:
                cell.stateLabel.text = self.filteredStates[indexPath.row].abbreviation
            case false:
                cell.stateLabel.text = self.states[indexPath.row].abbreviation
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case 0:
            if (kind == UICollectionElementKindSectionHeader) {
                let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        
        switch isFiltering {
        case true:
            self.selectedState = self.filteredStates[indexPath.row]
        default:
            self.selectedState = self.states[indexPath.row]
        }
        performSegue(withIdentifier: "goToStateProfile", sender: self.selectedState)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationvc = segue.destination as! StateProfileViewController
        destinationvc.state = self.selectedState
    }
}

extension StateCollectionViewController {
    
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
}



