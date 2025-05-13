//
//  NetworkManager.swift
//  PhotographyApp
//
//  Created by Elsever on 13.03.25.
//

import Foundation
import Alamofire

enum EncodingType {
    case url
    case json
}

final class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.unsplash.com/"
    let imageUrl = ""
    let appAccesKey = "x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4"
    let header: HTTPHeaders = ["Authorization": "Bearer \( UserDefaults.standard.string(forKey: "key") ?? "")"]
    let redirectUri = "urn:ietf:wg:oauth:2.0:oob"

    func request<T: Codable>(endPoint: String,
                              model: T.Type,
                              method: HTTPMethod = .get,
                              params: Parameters? = nil,
                              encodingType: EncodingType = .url,
                              completion: @escaping((T?, String?) -> Void)) {
        AF.request(endPoint,
                   method: method,
                   parameters: params,
                   encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                   headers: header).responseDecodable(of: model.self) { response in
            switch response.result {
                case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error.localizedDescription)
            }
        }
    }
    
    func request<T: Codable>(endPoint: String,
                             model: T.Type,
                             method: HTTPMethod = .get,
                             params: Parameters? = nil,
                             encodingType: EncodingType = .url) async throws -> T {
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endPoint,
                       method: method,
                       parameters: params,
                       encoding: encodingType == .url ? URLEncoding.default : JSONEncoding.default,
                       headers: header).responseDecodable(of: model.self) { response in
                switch response.result {
                case .success(let data):
                    if let _ = response.response?.allHeaderFields {
                        continuation.resume(returning: data)
                    }
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        }
    }
    
    func configureUrl(endPoint: String) -> String {
        return "\(baseUrl)\(endPoint)"
    }
}
