//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 17.07.24.
//

import Foundation

enum MovieEndpoint {
    case detail(id: Int)
    case similarMovies(id: Int)
    
    var path: String {
        switch self {
        case .detail(let id):
            return NetworkHelper.shared.requestUrl(url: "movie/\(id)")
        case .similarMovies(let id):
            return NetworkHelper.shared.requestUrl(url: "movie/\(id)/similar")
        }        
    }
}
