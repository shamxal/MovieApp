//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import Foundation

class HomeViewModel {
    let manager = HomeManager.shared
    
    var movie: Movie?
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    func getCategorItems() {
        manager.getCategoryMovies { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.movie = movie
                self?.successCallback?()
            }
        }
    }
    
    func numberOfItems() -> Int {
        movie?.results?.count ?? 0
    }
}
