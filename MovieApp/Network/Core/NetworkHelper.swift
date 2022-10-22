//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 24.09.22.
//

import Foundation

enum ErrorTypes: String, Error {
    case invalidData = "Invalid data"
    case invalidURL = "Invalid url"
    case generalError = "An error happened"
}

class NetworkHelper {
    static let shared = NetworkHelper()
        
    private let baseURL = "https://api.themoviedb.org/3/"
    private let apiKey = "e2253416fac0cd2476291eb33c92beb7"
    private let imageBasePath = "https://image.tmdb.org/t/p/original/"
    
    func requestUrl(url: String) -> String {
        baseURL + url + "?api_key=\(apiKey)"
    }
    
    func getImagePath(url: String) -> String {
        imageBasePath + url
    }
}
