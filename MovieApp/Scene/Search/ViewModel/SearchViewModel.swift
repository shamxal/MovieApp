//
//  SearchViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

class SearchViewModel {
    var item: Movie?
    var movieItems = [MovieResult]()
    
    var text = ""
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    func getItems() {
        SearchManager.shared.getSearchItems(text: text, page: item?.page ?? 0 + 1) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.item = movie
                if let movieItems = movie?.results, !movieItems.isEmpty {
                    self?.movieItems.append(contentsOf: movieItems)
                }
                self?.successCallback?()
            }
        }
    }
    
    func pagination(index: Int) {
        if let item = item {
            if (item.page ?? 0 <= item.totalPages ?? 0) && index == (movieItems.count - 1) {
                getItems()
            }
        }
    }
    
    func search(text: String) {
        resetDatas()
        self.text = text
        getItems()
    }
    
    func resetDatas() {
        text = ""
        item = nil
        movieItems.removeAll()
    }
}
