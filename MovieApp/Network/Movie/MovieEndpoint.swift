//
//  MovieEndpoint.swift
//  MovieApp
//
//  Created by Samxal Quliyev  on 17.07.24.
//

import Foundation

enum MovieEndpoint: String {
    case detail = "movie/"
    
    var path: String {
        NetworkHelper.shared.requestUrl(url: self.rawValue)
    }
}
