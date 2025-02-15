//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 18.11.22.
//

import UIKit
import Foundation

class MovieViewModel {
    private var movieId: Int
    private var movieData: MovieDetail?
    var coordinator: MovieDetailCoordinator
    
    var dtoData = [MovieDetailDTO]()
    var similarMovies = [MovieResult]()
    var videos = [MovieVideoResult]()
    
    var isFavoriteMovie = false
    var successCallback: (() -> Void)?
    var favoriteCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    init(movieId: Int, coordinator: MovieDetailCoordinator) {
        self.movieId = movieId
        self.coordinator = coordinator
        
        FirebaseManager.isMovieInFavoriteList(movieId: movieId) { [weak self] data, _ in
            if let _ = data {
                self?.isFavoriteMovie = true
            }
            self?.favoriteCallback?()
        }
        getMovieDetail()
    }
    
    fileprivate func getMovieDetail() {
        MovieManager.getMovieDetail(id: movieId) { [weak self] data, error in
            if let error {
                self?.errorCallback?(error)
            } else if let data {
                self?.movieData = data
                self?.configureDTO()
                self?.getSimilarMovies()
                self?.getMovieTrailer()
                self?.successCallback?()
            }
        }
    }
    
    fileprivate func getSimilarMovies() {
        MovieManager.getSimilarMovies(id: movieId) { [weak self] data, error in
            if let error {
                self?.errorCallback?(error)
            } else if let data, let movies = data.results {
                self?.similarMovies = movies
                self?.dtoData.append(.init(data: "Similar Movies", type: .title))
                self?.dtoData.append(.init(data: movies, type: .similarMovies))
                self?.successCallback?()
            }
        }
    }
    
    fileprivate func getMovieTrailer() {
        MovieManager.getMovieTrailers(id: movieId) {  [weak self] data, error in
            if let error {
                self?.errorCallback?(error)
            } else if let data, let videos = data.results {
                self?.videos = videos
            }
        }
    }
    
    fileprivate func configureDTO() {
        if let data = movieData {
            dtoData.append(.init(data: data.posterImage, type: .media))
            dtoData.append(.init(data: MovieInfoData(title: data.originalTitle ?? "",
                                                     duration: "\(data.runtime ?? 0) minutes",
                                                     rating: "\(String(format: "%.1f", data.voteAverage ?? 0.0)) (IMDB)",
                                                     releaseDate: data.releaseDate ?? "",
                                                     genre: data.genreItems),
                                 type: .info))
            dtoData.append(.init(data: data.overview ?? "", type: .overview))
            
        }
    }
    
    func showVideoList(controller: UIViewController) {
        UserDefaultsHelper.get(key: .premium) ? coordinator.showVideList(videos: videos) : coordinator.showPremiumPage(controller: controller)
    }
    
    func addMovieToFavorite(controller: UIViewController) {
        if UserDefaultsHelper.get(key: .premium) {
            if UserDefaultsHelper.get(key: .isLoggedIn) {
                addToFavorite()
            } else {
                FirebaseManager.signInAnonymously { [weak self] in
                    self?.addToFavorite()
                }
            }
        } else {
            coordinator.showPremiumPage(controller: controller)
        }
    }
    
    fileprivate func addToFavorite() {
        guard let movieData else { return }
        FirebaseManager.addFavoriteMovie(movie: movieData) { [weak self] in
            self?.isFavoriteMovie = true
            self?.favoriteCallback?()
        }
    }
    
    func removeFromFavorite() {
        FirebaseManager.remoeFvromFavorite(movieId: movieId)
    }
}
