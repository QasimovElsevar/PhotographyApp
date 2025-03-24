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

class NetworkManager {
    static let shared = NetworkManager()
    
    let baseUrl = "https://api.unsplash.com/"
    let imageUrl = ""
    let header: HTTPHeaders = ["Client-ID": UserDefaults.standard.string(forKey: "key") ?? "x8sJp7pb7aDawfONcfXXuwkjGhCJecnUvbR-vZBQtC4"]
    let redirectUri = "com.elsevar.PhotographyApp:/oauth2redirect/google"
    
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
    
    func configureUrl(endPoint: String) -> String {
        return "\(baseUrl)\(endPoint)"
    }
}
