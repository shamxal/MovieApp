//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 22.07.24.
//

import Foundation
import FirebaseFirestore
    
class FirebaseManager {
    let db = Firestore.firestore()
    
    func addFavoriteMovie(movie: MovieDetail) {
        let data: [String : Any] = [
            "userId": UUID().uuidString,
            "title": movie.originalTitle ?? "",
            "posterImage": movie.posterImage,
            "rating": movie.voteAverage ?? 0.0,
            "genres": movie.genreItems,
            "description": movie.overview ?? ""
        ]
        db.collection("FavoriteMovies").document().setData(data)
    }
}
