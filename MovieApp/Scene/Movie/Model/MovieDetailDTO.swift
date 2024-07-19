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
}

struct MovieInfoData {
    let title: String
    let duration: String
    let rating: String
    let releaseDate: String
    let genre: [String]
}
