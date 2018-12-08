//  GTRHomeVC+SearchBarDelegate.swift
//  GitRiver
//  Created by Akhilesh Amle on 08/12/18.
//  Copyright © 2018 AkhileshAmle. All rights reserved.

import UIKit

extension GTRHomeViewController : UISearchBarDelegate {

    // MARK: - Private
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else { return }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        queryService.getSearchResults(searchedTerm: searchText) { (results, errorMessage) in
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
            
            if let results = results {
            self.searchedItems = results
            }
        }
    }
}
