//
//  FeedLayout.swift
//  PhotographyApp
//
//  Created by Elsever on 16.04.25.
//

import UIKit

final class FeedLayout {
    static func createHorizontalDoubleCell() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(200)), subitems: [item, item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
        group.contentInsets.bottom = 2

        let section = NSCollectionLayoutSection(group: group)
       return section
    }
    
    static func profileCollection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.95)), subitems: [item])
        group.contentInsets = .init(top: 2, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
