//
//  ImageSaver.swift
//  PhotographyApp
//
//  Created by Elsever on 18.04.25.
//

import UIKit

class ImageSaver: NSObject {
    
    var success: (() -> Void)?
    var failure: ((String) -> Void)?
    
    func writeToPhotoAlbum (image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector (saveCompleted), nil)
    }
    
    @objc func saveCompleted(_ image: UIImage, didFiniishSavingWithError error: Error?, contextInfo: UnsafeRawPointer?) {
        if let error = error {
            failure?(error.localizedDescription)
        } else {
            success?()
        }
    }
}

