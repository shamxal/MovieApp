//
//  PeopleHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

enum PeopleEndpoint: String {
    case popular = "person/popular"
    
    var path: String {
        switch self {
        case .popular:
            return NetworkHelper.shared.requestUrl(url: PeopleEndpoint.popular.rawValue)
        }
    }
}
