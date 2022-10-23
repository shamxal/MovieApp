//
//  HomeViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.09.22.
//

import Foundation

class HomeViewModel {
    var coordinator: HomeCoordinator?
    
    let manager = HomeManager.shared
    
    var movie: Movie?
    var movieCategory: MovieCategory = .popular
    var genreItems = [GenreElement]()
    var nowPlayingItems = [MovieResult]()
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    func getNowPlaying() {
        manager.getCategoryMovies(type: .nowPlaying) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                if let movie = movie {
                    self?.nowPlayingItems = movie.results ?? []
                    self?.successCallback?()
                }
            }
        }
    }
    
    func getCategorItems() {
        manager.getCategoryMovies(type: movieCategory) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.movie = movie
                self?.successCallback?()
            }
        }
    }
    
    func getGenreItems() {
        manager.getGenres { [weak self] items, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.genreItems = items ?? []
                GenreHandler.shared.setItems(items: items ?? [])
                self?.getCategorItems()
            }
        }
    }
    
    func numberOfItems() -> Int {
        movie?.results?.count ?? 0
    }
}
