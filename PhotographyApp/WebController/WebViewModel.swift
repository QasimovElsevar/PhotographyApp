//
//  WebViewMOdel.swift
//  PhotographyApp
//
//  Created by Elsever on 29.03.25.
//

import Foundation
import UIKit

final class WebViewModel {

    func cutURL(url: String) -> String {
        let urlArray = url.split(separator: "=")
        return String(urlArray[1])
    }
}
