//
//  MovieManager.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 18.07.24.
//

import Foundation

protocol MovieManagerProtocol {
    static func getMovieDetail(id: Int, complete: @escaping((MovieDetail?, String?)->()))
}

class MovieManager: MovieManagerProtocol {
    static func getMovieDetail(id: Int, complete: @escaping ((MovieDetail?, String?) -> ())) {
        NetworkManager.shared.request(type: MovieDetail.self, url: MovieEndpoint.detail.path + "\(id)", completion: complete)
    }
}
