//
//  FirebaseManager.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 22.07.24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
    
class FirebaseManager {
    static let db = Firestore.firestore()
    
    static let favoriteCollection = "FavoriteMovies"
    static let userId = UserDefaults.standard.string(forKey: "userId") ?? ""
    
    static func addFavoriteMovie(movie: MovieDetail, completion: @escaping(() -> Void)) {
        guard let movieId = movie.id else { return }
        let data: [String : Any] = [
            "userId": userId,
            "movieId": movie.id ?? 0,
            "title": movie.originalTitle ?? "",
            "poster": movie.posterImage,
            "rating": movie.voteAverage ?? 0.0,
            "genres": movie.genreItems,
            "description": movie.overview ?? ""
        ]
        db.collection(favoriteCollection).document("\(userId)-\(movieId)").setData(data) { error in
            if error == nil {
                completion()
            }
        }
    }
    
    static func remoeFvromFavorite(movieId: Int) {
        db.collection(favoriteCollection).document("\(userId)-\(movieId)").delete()
    }
    
    static func getFavoriteMovies(complete: @escaping(([Favorite]?, String?) -> Void)) {
        db.collection(favoriteCollection).getDocuments { snapshot, error in
            if let error {
                complete(nil, error.localizedDescription)
            } else if let documents = snapshot?.documents {
                var movies = [Favorite]()
                for document in documents {
                    if let data = try? JSONSerialization.data(withJSONObject: document.data(), options: []) {
                        guard let movie = try? JSONDecoder().decode(Favorite.self, from: data) else { return }
                        movies.append(movie)
                    }
                }
                complete(movies, nil)
            }
        }
    }
    
    static func isMovieInFavoriteList(movieId: Int, complete: @escaping((Favorite?, String?) -> Void)) {
        db.collection(favoriteCollection).whereField("movieId", isEqualTo: movieId).getDocuments { snapshot, error in
            if let error {
                complete(nil, error.localizedDescription)
            } else if let documents = snapshot?.documents {
                var movies = [Favorite]()
                for document in documents {
                    if let data = try? JSONSerialization.data(withJSONObject: document.data(), options: []) {
                        guard let movie = try? JSONDecoder().decode(Favorite.self, from: data) else { return }
                        movies.append(movie)
                    }
                }
                complete(movies.first, nil)
            }
        }
    }
    
    static func signInAnonymously(complete: @escaping(() -> Void)) {
        Auth.auth().signInAnonymously { authResult, error in
            guard let user = authResult?.user else { return }
            let isAnonymous = user.isAnonymous  // true
            let uid = user.uid
            UserDefaults.standard.set(uid, forKey: "userId")
            UserDefaults.standard.set(true, forKey: "isLoggedIn")
            complete()
        }
    }
}
