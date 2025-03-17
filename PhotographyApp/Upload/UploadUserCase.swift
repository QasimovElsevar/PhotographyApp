//
//  UploadUserCase.swift
//  PhotographyApp
//
//  Created by Elsever on 17.03.25.
//

import Foundation

protocol UploadUserCase {
    func getData(completion: @escaping ([Topics]?, String?) -> Void)
}
