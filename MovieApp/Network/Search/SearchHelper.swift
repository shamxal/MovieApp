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
        NetworkHelper.shared.requestUrl(url: self.rawValue)
    }
}
