//
//  SearchHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

enum SearchEndpoint: String {
    case search = "search/movie"
    
    var path: String {
        switch self {
        case .search:
            return NetworkHelper.shared.requestUrl(url: SearchEndpoint.search.rawValue)
        }
    }
}
