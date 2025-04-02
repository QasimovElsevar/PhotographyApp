//
//  ProfileCellLayout.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import Foundation
import UIKit

class ProfileCellLayout {
    static func profileCell() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.25)), subitems: [item])
        
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
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitems: [item])
        group.contentInsets = .init(top: 10, leading: 0, bottom: 0, trailing: 0)
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
