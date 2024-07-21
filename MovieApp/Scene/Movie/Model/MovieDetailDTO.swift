//
//  MovieDetailDTO.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 18.07.24.
//

import Foundation

struct MovieDetailDTO {
    let data: Any
    let type: MovieDetailLayoutType
}

enum MovieDetailLayoutType {
    case media
    case info
    case overview
    case title
    case similarMovies
}

struct MovieMediaData {
    let posterImage: String
    let trailerId: String
}

struct MovieInfoData {
    let title: String
    let duration: String
    let rating: String
    let releaseDate: String
    let genre: [String]
}
