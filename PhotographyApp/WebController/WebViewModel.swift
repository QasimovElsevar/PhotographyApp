//
//  WebViewMOdel.swift
//  PhotographyApp
//
//  Created by Elsever on 29.03.25.
//

import Foundation
import UIKit

class WebViewModel {
    
    let builder: UserBuilder
    var success: (() -> Void)?
    
    init (builder: UserBuilder) {
        self.builder = builder
    }

    func cutURL(url: String) -> String {
        let urlArray = url.split(separator: "=")
        return String(urlArray[1])
    }
}
