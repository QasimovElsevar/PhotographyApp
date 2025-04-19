//
//  SearchResultViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import UIKit

class SearchResultViewModel {
    
    var isSearched = false
    var query: String = ""
    
    var filteredSuggestions: [UISearchSuggestion] = []
    
    var suggestions: [UISearchSuggestion] = [
        UISearchSuggestionItem(
            localizedSuggestion: "Walpapperrrrr"
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
}
