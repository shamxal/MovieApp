//
//  HomeManager.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 24.09.22.
//

import Foundation

protocol HomeManagerProtocol {
    func getGenres(complete: @escaping(([GenreElement]?, Error?)->()))
    func getCategoryMovies(complete: @escaping((Movie?, Error?)->()))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getGenres(complete: @escaping (([GenreElement]?, Error?) -> ())) {
        NetworkManager.shared.request(type: Genre.self,
                                      url: HomeEndpoint.genre.path,
                                      method: .get) { response in
            switch response {
            case .success(let data):
                complete(data.genres, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
    
    func getCategoryMovies(complete: @escaping ((Movie?, Error?) -> ())) {
        NetworkManager.shared.request(type: Movie.self,
                                      url: HomeEndpoint.popular.path,
                                      method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
