//
//  ViewController.swift
//  PWR
//
//  Created by Amber Spadafora on 10/3/17.
//  Copyright © 2017 Amber Spadafora. All rights reserved.
//

import UIKit

class StateCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {

    var parserDelegate: ParserDelegate!
    var stateData = States.shared.states
    var filteredData: [String] = [] {
        didSet {
            print(filteredData.count)
            self.collectionView?.reloadSections(IndexSet(integer:1))
        }
    }
    
    var senatorStateMap: [String: [Senator]]!
    var isFiltering: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.parserDelegate = ParserDelegate()
        setUpCollectionView()
        
    }
    
    // MARK: Helper Functions
    
    func setUpCollectionView(){
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.view.backgroundColor = UIColor.white
    }
    
    func filterStatesForSearchText(_ searchText: String) {
        self.filteredData = self.stateData.filter{$0.lowercased().hasPrefix(searchText.lowercased())}
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
        case 0:
            return 0
        case 1:
            if isFiltering {
                print("This is the filteredDataCount \(filteredData.count)")
                return filteredData.count
            } else {
                return stateData.count
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
                cell.stateLabel.text = self.filteredData[indexPath.row]
            case false:
                cell.stateLabel.text = self.stateData[indexPath.row]
            }
            
            return cell
        }
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if indexPath.section == 0 {
            if (kind == UICollectionElementKindSectionHeader) {
                let headerView:UICollectionReusableView =  collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CollectionViewHeader", for: indexPath)
                return headerView
            }
            return UICollectionReusableView()
        } else {
            let reusableView = UICollectionReusableView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
            return reusableView
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 1 {
            return CGSize.zero
        }
        return CGSize(width: 50, height: 50)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch isFiltering {
        case true:
            let selectedState = self.filteredData[indexPath.row]
            let state: State = State(abbreviation: selectedState, title: States.shared.stateDictionary[selectedState]!, senators: self.senatorStateMap[selectedState]!)
            print(state.title)
            
        default:
            let selectedState = self.stateData[indexPath.row]
            let state: State = State(abbreviation: selectedState, title: States.shared.stateDictionary[selectedState]!, senators: self.senatorStateMap[selectedState]!)
            print(state.title)
        }
    }
}

extension StateCollectionViewController {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.isFiltering = true
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.isFiltering = true
        self.filteredData = self.stateData.filter{$0.lowercased().hasPrefix(searchText.lowercased())}
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.isFiltering = false
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



