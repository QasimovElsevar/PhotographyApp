//
//  FeedUseCase.swift
//  PhotographyApp
//
//  Created by Elsever on 12.04.25.
//

import Foundation

protocol FeedUserCase {
    func getList(page: Int) async throws -> [Photos]
}
