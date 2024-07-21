//
//  MovieManager.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 18.07.24.
//

import Foundation

protocol MovieManagerProtocol {
    static func getMovieDetail(id: Int, complete: @escaping((MovieDetail?, String?)->()))
    static func getSimilarMovies(id: Int, complete: @escaping((Movie?, String?)->()))
    static func getMovieTrailers(id: Int, complete: @escaping((MovieVideo?, String?)->()))
}

class MovieManager: MovieManagerProtocol {
    static func getMovieDetail(id: Int, complete: @escaping ((MovieDetail?, String?) -> ())) {
        NetworkManager.shared.request(type: MovieDetail.self, 
                                      url: MovieEndpoint.detail(id: id).path,
                                      completion: complete)
    }
    
    static func getSimilarMovies(id: Int, complete: @escaping ((Movie?, String?) -> ())) {
        NetworkManager.shared.request(type: Movie.self,
                                      url: MovieEndpoint.similarMovies(id: id).path,
                                      completion: complete)
    }
    
    static func getMovieTrailers(id: Int, complete: @escaping ((MovieVideo?, String?) -> ())) {
        NetworkManager.shared.request(type: MovieVideo.self,
                                      url: MovieEndpoint.movieTrailer(id: id).path,
                                      completion: complete)
    }
}
