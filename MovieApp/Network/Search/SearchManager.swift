//
//  SearchManager.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

protocol SearchManagerProtocol {
    func getSearchItems(text: String, page: Int, complete: @escaping((Movie?, Error?)->()))
}

class SearchManager: SearchManagerProtocol {
    static let shared = SearchManager()
    
    func getSearchItems(text: String, page: Int, complete: @escaping ((Movie?, Error?) -> ())) {
        NetworkManager.shared.request(type: Movie.self,
                                      url: SearchEndpoint.search(query: text, page: page).path,
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
