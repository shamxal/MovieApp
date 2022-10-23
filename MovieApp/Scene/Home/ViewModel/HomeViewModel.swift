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
    var movieItems = [MovieResult]()
    var genreItems = [GenreElement]()
    var nowPlayingItems = [MovieResult]()
    
    var movieCategory: MovieCategory = .popular
    
    var errorCallback: ((String)->())?
    var successCallback: (()->())?
    
    func getNowPlaying() {
        manager.getCategoryMovies(type: .nowPlaying, page: 1) { [weak self] movie, error in
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
        manager.getCategoryMovies(type: movieCategory, page: (movie?.page ?? 0) + 1) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.movie = movie
                if let movieItems = movie?.results, !movieItems.isEmpty {
                    self?.movieItems.append(contentsOf: movieItems)
                }
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
    
    func pagination(index: Int) {
        if let item = movie {
            if (item.page ?? 0 <= item.totalPages ?? 0) && index == (movieItems.count - 1) {
                getCategorItems()
            }
        }
    }
}
