//
//  Genre.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

// MARK: - Genre
struct Genre: Codable {
    let genres: [GenreElement]?
}

// MARK: - GenreElement
struct GenreElement: Codable {
    let id: Int?
    let name: String?
}
