//
//  PeopleManager.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

protocol PeopleManagerProtocol {
    func getPopularPeople(page: Int, complete: @escaping((People?, Error?)->()))
}

class PeopleManager: PeopleManagerProtocol {
    static let shared = PeopleManager()
    
    func getPopularPeople(page: Int, complete: @escaping ((People?, Error?) -> ())) {
        NetworkManager.shared.request(type: People.self,
                                      url: PeopleEndpoint.popular.path + "&page=\(page)",
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
