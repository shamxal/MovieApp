//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 18.11.22.
//

import Foundation

class MovieViewModel {
    var movieId: Int
    var movieData: MovieDetail?
    
    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init(movieId: Int) {
        self.movieId = movieId
        
        getMovieDetail()
    }
    
    fileprivate func getMovieDetail() {
        MovieManager.getMovieDetail(id: movieId) { [weak self] data, error in
            if let error {
                self?.errorCallback?(error)
            } else if let data {
                self?.movieData = data
                self?.successCallback?()
            }
        }
    }
}
