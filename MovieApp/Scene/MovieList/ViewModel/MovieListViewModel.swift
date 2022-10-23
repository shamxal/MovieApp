//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 23.10.22.
//

import Foundation

enum MovieListType {
    case person
}

class MovieListViewModel {
    let id: Int?
    var items = [MovieResult]()
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    init(id: Int, type: MovieListType) {
        self.id = id
        
        switch type {
        case .person:
            getPersonMovieList()
        }
    }
    
    fileprivate func getPersonMovieList() {
        PeopleManager.shared.getPopularPeopleMovieList(id: id ?? 0) { [weak self] movieList, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else if let movieList = movieList {
                self?.items = movieList.cast ?? []
                if movieList.cast?.isEmpty ?? false {
                    self?.items = movieList.crew ?? []
                }
                self?.successCallback?()
            }
        }
    }
}
