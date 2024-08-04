//
//  NetworkManager.swift
//  MovieApp
//
//  Created by Shamkhal Guliyev on 24.09.22.
//

import Alamofire
import Foundation

class NetworkManager {    
    static let shared = NetworkManager()
    
    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethod = .get,
                             completion: @escaping((Result<T, ErrorTypes>)->())) {
        let url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        print("url: \(url)")
        print("header: \(NetworkHelper.shared.getHeaders())")
        AF.request(url,
                   method: method,
                   headers: NetworkHelper.shared.getHeaders()).responseData { response in
            switch response.result {
            case .success(let data):
                self.handleResponse(data: data) { response in
                    completion(response)
                }
            case .failure(let error):
                print("error: \(error.localizedDescription)")
                completion(.failure(.generalError))
            }
        }
    }
    
    func request<T: Codable>(type: T.Type,
                             url: String,
                             method: HTTPMethod = .get,
                             completion: @escaping((T?, String?) -> Void)) {
        AF.request(url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "",
                   method: method,
                   headers: NetworkHelper.shared.getHeaders()).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    fileprivate func handleResponse<T: Codable>(data: Data, completion: @escaping((Result<T, ErrorTypes>)->())) {
        do {
            let result = try JSONDecoder().decode(T.self, from: data)
            completion(.success(result))
            print("response: \(result)")
        } catch {
            print("error: \(error.localizedDescription)")
            completion(.failure(.invalidData))
        }
    }
}
