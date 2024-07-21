//
//  MovieVideo.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 21.07.24.
//

import Foundation

// MARK: - MovieVideo
struct MovieVideo: Codable {
    let id: Int?
    let results: [MovieVideoResult]?
}

// MARK: - MovieVideoResult
struct MovieVideoResult: Codable {
    let iso639_1: String?
    let iso3166_1: String?
    let name, key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt, id: String?

    enum CodingKeys: String, CodingKey {
        case iso639_1 = "iso_639_1"
        case iso3166_1 = "iso_3166_1"
        case name, key, site, size, type, official
        case publishedAt = "published_at"
        case id
    }
}
