//
//  PageControlCell.swift
//  PhotographyApp
//
//  Created by Elsever on 24.04.25.
//

import UIKit

class PageControlCell: UICollectionViewCell {
    
    private lazy var pageControl: UIPageControl = {
      let pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = .lightGray
        pageControl.currentPageIndicatorTintColor = .label
        pageControl.backgroundStyle = .minimal
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        return pageControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        addSubview(pageControl)
        
        NSLayoutConstraint.activate([
            pageControl.centerXAnchor.constraint(equalTo: centerXAnchor),
            pageControl.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    func configure(numberOfPages: Int, currentPage: Int) {
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPage = currentPage
    }
}
