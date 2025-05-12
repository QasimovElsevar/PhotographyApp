//
//  PhotoInfoViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 12.05.25.
//

import Foundation

final class PhotoInfoViewModel {
    
    var photo: PhotoDetails?
    
    init(photo: PhotoDetails? = nil) {
        self.photo = photo
    }
}
