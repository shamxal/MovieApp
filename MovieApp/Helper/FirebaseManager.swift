//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 22.07.24.
//

import Foundation
import FirebaseFirestore
    
class FirebaseManager {
    static let db = Firestore.firestore()
    
    static let favoriteCollection = "FavoriteMovies"
    
    static func addFavoriteMovie(movie: MovieDetail) {
        let data: [String : Any] = [
            "userId": UUID().uuidString,
            "title": movie.originalTitle ?? "",
            "poster": movie.posterImage,
            "rating": movie.voteAverage ?? 0.0,
            "genres": movie.genreItems,
            "description": movie.overview ?? ""
        ]
        db.collection(favoriteCollection).document().setData(data)
    }
    
    static func getFavoriteMovies(complete: @escaping(([Favorite]?, String?) -> Void)) {
        db.collection(favoriteCollection).getDocuments { snapshot, error in
            if let error {
                complete(nil, error.localizedDescription)
            } else if let data = snapshot?.documents {
                if let data = try? JSONSerialization.data(withJSONObject: data, options: []) {
                    guard let movies = try? JSONDecoder().decode([Favorite].self, from: data) else { return }
                    complete(movies, nil)
                }
            }
        }
    }
}
