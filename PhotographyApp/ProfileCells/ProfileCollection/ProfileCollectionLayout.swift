//
//  File.swift
//  PhotographyApp
//
//  Created by Elsever on 24.03.25.
//

import Foundation
import UIKit

final class ProfileCollectionLayout {
    
    static func profileCell() -> UICollectionViewCompositionalLayout {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
        
        let group = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(300)), subitems: [item])
        group.contentInsets = .init(top: 4, leading: 0, bottom: 4, trailing: 0)
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }
    
}
