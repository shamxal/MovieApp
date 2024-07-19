//
//  PeopleHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 15.10.22.
//

import Foundation

enum PeopleEndpoint {
    case popular(page: Int)
    
    var path: String {
        switch self {
        case .popular(let page):
            NetworkHelper.shared.requestUrl(url: "person/popular?page=\(page)")
        }
        
    }
}
