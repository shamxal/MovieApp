//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

class SearchViewModel {
    var item: Movie?
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getItems(text: String) {
        SearchManager.shared.getSearchItems(text: text) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.item = movie
                self?.successCallback?()
            }
        }
    }
}
