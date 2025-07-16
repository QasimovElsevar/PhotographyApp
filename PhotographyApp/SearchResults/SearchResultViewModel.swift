//
//  SearchResultViewModel.swift
//  PhotographyApp
//
//  Created by Elsever on 19.04.25.
//

import UIKit

final class SearchResultViewModel {
    
    var isSearched = false
    var query: String = ""
    
    var filteredSuggestions: [UISearchSuggestion] = []
    
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
        UISearchSuggestionItem(
            localizedSuggestion: "Walls"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Winter"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Sun"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Sad"
        ),
        UISearchSuggestionItem(
            localizedSuggestion: "Sprites"
        ),
    ]
}
