//
//  SearchHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

enum SearchEndpoint {
    case search(query: String, page: Int)
        
    var path: String {
        switch self {
        case .search(let query, let page):
            return NetworkHelper.shared.requestUrl(url: "search/movie?query=\(query)&page=\(page)")
        }
    }
}
