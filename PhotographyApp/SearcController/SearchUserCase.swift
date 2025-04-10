//
//  SearchUserCase.swift
//  PhotographyApp
//
//  Created by Elsever on 10.04.25.
//

import Foundation

protocol SearchUserCase {
    func search(query: String) async throws -> [Photos]
}
