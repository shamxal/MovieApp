//
//  Favorite.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 23.07.24.
//

import Foundation

struct Favorite: Codable, MovieCellProtocol {
    let userId: String?
    let movieId: Int?
    let title: String?
    let poster: String?
    let rating: Double?
    let genres: [String]?
    let description: String?
    
    var posterImage: String {
        poster ?? ""
    }
    
    var titleText: String {
        title ?? ""
    }
    
    var ratingText: String {
        "\(rating ?? 0.0)"
    }
    
    var genreItems: [String] {
        genres ?? []
    }
    
    var overViewText: String {
        description ?? ""
    }
}
