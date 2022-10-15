//
//  HomeHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 24.09.22.
//

import Foundation

enum HomeEndpoint: String {
    case popular = "movie/popular"
    case genre = "genre/movie/list"
    
    var path: String {
        switch self {
        case .popular:
            return NetworkHelper.shared.requestUrl(url: HomeEndpoint.popular.rawValue)
        case .genre:
            return NetworkHelper.shared.requestUrl(url: HomeEndpoint.genre.rawValue)
        }
    }
}
