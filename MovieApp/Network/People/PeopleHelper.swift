//
//  PeopleHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

enum PeopleEndpoint {
    case popular(page: Int)
    case movieList(id: Int)
    
    var path: String {
        switch self {
        case .popular(let page):
            return NetworkHelper.shared.requestUrl(url: "person/popular?page=\(page)")
        case .movieList(let id):
            return NetworkHelper.shared.requestUrl(url: "person/\(id)/movie_credits")
        }
        
    }
}
