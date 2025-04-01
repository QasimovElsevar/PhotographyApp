//
//  UploadManager.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

class UploadManager: UploadUserCase {
    
    let networkManager = NetworkManager()
    
    func getData(completion: @escaping ([Photos]?, String?) -> Void) {
        let path = TopicsEndPoint.list.path
        networkManager.request(endPoint: path, model: [Photos].self, completion: completion)
    }
}
