//
//  SearchViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 26.03.25.
//

import Foundation
import UIKit

enum Section {
    case browseText
    case browse
    case discoverText
    case discover
}

final class SearchViewModel {
    var coordinator: MainCoordinator?
    
    let sections: [Section] = [
        .browseText,
        .browse,
        .discoverText,
        .discover
    ]
    
    let categories = [
        "Minimal",
        "Nature",
        "Flowers",
        "Film",
        "Animals",
        "Abstract",
        "Sky",
        "Space",
        "Sport",
        "Travel"
    ]
    
    var suggestions: [UISearchSuggestion] = [
        UISearchSuggestionItem(
            localizedSuggestion: "Walpapper"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Summer"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Forest"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Italy"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Beach"
        ),
    ]
    
    //MARK: - States
    
    enum ViewState {
        case success
        case error(String)
        case idle
    }
    
    var searchResult: Search?
    var searchArray = [Result]()
    var query = ""
    var page = 1
    
    let manager = SearchManager()
    
    var stateUpdate: ((ViewState) -> Void)?
    
    var state: ViewState = .idle {
        didSet {
            stateUpdate?(state)
        }
    }

    //MARK: - Collection configuration
    
    func createLayaout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { sectionNumber, environment in
            switch self.sections[sectionNumber] {
            case .browseText:
                SearchLayout.CreateTextSizeLayout()
            case .browse:
                SearchLayout.createVerticalDoubleCell()
            case .discoverText:
                SearchLayout.CreateTextSizeLayout()
            case .discover:
                SearchLayout.createHorizontalDoubleCell()
            }
        }
    }
    
    func numberOfSections(index: Int) -> Int {
        switch sections[index] {
        case .browseText, .discoverText:
            1
        case .browse:
            categories.count
        case .discover:
            searchArray.count
        }
    }
    
    //MARK: - Data
    
    func getList(query: String) async {
        reset()
        do {
            let data =  try await manager.getSearchResult(query: query, page: page)
            Task {
                searchResult = data
                searchArray.append(contentsOf: searchResult?.results ?? [])
                state = .success
                page += 1
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    func getPages(query: String) async {
        do {
            let data =  try await manager.getSearchResult(query: query, page: page)
            Task {
                searchResult = data
                searchArray.append(contentsOf: searchResult?.results ?? [])
                print(searchResult?.totalPages ?? 0)
                print(searchArray.count)
                state = .success
                page += 1
            }
        } catch {
            Task {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    private func reset() {
        page = 1
        searchArray.removeAll()
    }
}
