//
//  ProfileCellLayout.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import Foundation
import UIKit

final class ProfileCellLayout {
    
    static func profileCell() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35)), subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    static func selectionCell() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(60)), subitems: [item])
        group.contentInsets = .init(top: 15, leading: 12, bottom: 15, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    static func profileCollection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.22)), subitems: [item])
        group.contentInsets = .init(top: 0, leading: 12, bottom: 15, trailing: 12)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    static func likedPhotos() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.9)), subitems: [item])
        group.contentInsets.bottom = 2
        
        let section = NSCollectionLayoutSection(group: group)

        return section
    }
    
    static func createHorizontalDoubleCell() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(230)), subitems: [item, item])
        group.interItemSpacing = NSCollectionLayoutSpacing.fixed(2)
        group.contentInsets.bottom = 2

        let section = NSCollectionLayoutSection(group: group)
        return section
    }
}
