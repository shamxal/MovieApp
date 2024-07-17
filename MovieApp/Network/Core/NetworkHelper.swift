//
//  NetworkHelper.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 24.09.22.
//

import Foundation
import Alamofire

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
    private let bearerToken = "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlMjI1MzQxNmZhYzBjZDI0NzYyOTFlYjMzYzkyYmViNyIsInN1YiI6IjYyNDNmMjAyYzUwYWQyMDA1Y2RlOTVmMCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.0dUMhxX4qBZrY_NXSEf9cWjAnzB-Xl1Qu5rj9CzET7k"
    
    func requestUrl(url: String) -> String {
        baseURL + url
    }
    
    func getImagePath(url: String) -> String {
        imageBasePath + url
    }
    
    func getHeaders() -> HTTPHeaders {
        ["Authorization": "Bearer \(bearerToken)"]
    }
}
