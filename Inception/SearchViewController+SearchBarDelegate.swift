//
//  SearchViewController+SearchBarDelegate.swift
//  Inception
//
//  Created by David Ehlen on 14.10.15.
//  Copyright © 2015 David Ehlen. All rights reserved.
//

import UIKit

extension SearchViewController : UISearchBarDelegate {
    
    /* UISearchBar Delegate */
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.searchBar.text = ""
        self.results.removeAll()
        self.searchBar.resignFirstResponder()
        
        isSearching = false
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        self.activityIndicator.startAnimating()
        self.results.removeAll()
        self.searchBar.resignFirstResponder()
        
        isSearching = true
        
        if let searchText = searchBar.text {
            APIController.request(APIEndpoints.MultiSearch(searchText)) { (data:AnyObject?, error:NSError?) in
                self.activityIndicator.stopAnimating()
                if (error != nil) {
                    AlertFactory.showAlert("errorTitle",localizeMessageKey:"networkErrorMessage", from:self)
                    self.searchBar.resignFirstResponder()
                } else {
                    self.results = JSONParser.mutliSearchResults(data)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
}
