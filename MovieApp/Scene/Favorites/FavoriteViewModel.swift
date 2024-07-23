//
//  FavoriteViewModel.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 23.07.24.
//

import Foundation

class FavoriteViewModel {
    var items = [Favorite]()
    
    var successCallback: (() -> Void)?
    var errorCallback: ((String) -> Void)?
    
    func getFavoriteItems() {
        FirebaseManager.getFavoriteMovies { [weak self] data, errorMessage in
            if let errorMessage {
                self?.errorCallback?(errorMessage)
            } else if let data {
                self?.items = data
                self?.successCallback?()
            }
        }
    }
}
