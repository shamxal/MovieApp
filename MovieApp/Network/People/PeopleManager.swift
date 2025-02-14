//
//  PeopleManager.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

protocol PeopleManagerUseCase {
    func getPopularPeople(page: Int, complete: @escaping((People?, String?)->()))
    func getPopularPeopleMovieList(id: Int, complete: @escaping((PeopleMovieList?, Error?)->()))
}

class PeopleManager: PeopleManagerUseCase {
    static let shared = PeopleManager()
    
    func getPopularPeople(page: Int, complete: @escaping ((People?, String?) -> ())) {
        NetworkManager.shared.request(type: People.self,
                                      url: PeopleEndpoint.popular(page: page).path,
                                      completion: complete)
    }
    
    func getPopularPeopleMovieList(id: Int, complete: @escaping ((PeopleMovieList?, Error?) -> ())) {
        NetworkManager.shared.request(type: PeopleMovieList.self,
                                      url: PeopleEndpoint.movieList(id: id).path,
                                      method: .get) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
