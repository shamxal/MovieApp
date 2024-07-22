//
//  MovieViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 18.11.22.
//

import Foundation

class MovieViewModel {
    private var movieId: Int
    private var movieData: MovieDetail?
    private var coordinator: MovieDetailCoordinator
    
    var dtoData = [MovieDetailDTO]()
    var similarMovies = [MovieResult]()
    var videos = [MovieVideoResult]()
    
    var firebaseManager = FirebaseManager()
    
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
    
    func showVideList() {
        coordinator.showVideList(videos: videos)
    }
    
    func addMovieToFavorite() {
        guard let movieData else { return }
        firebaseManager.addFavoriteMovie(movie: movieData)
    }
}
