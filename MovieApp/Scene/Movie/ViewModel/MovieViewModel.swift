//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 18.11.22.
//

import Foundation

class MovieViewModel {
    private var movieId: Int
    var movieData: MovieDetail?
    private var coordinator: MovieDetailCoordinator
    
    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init(movieId: Int, coordinator: MovieDetailCoordinator) {
        self.movieId = movieId
        self.coordinator = coordinator
        
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
