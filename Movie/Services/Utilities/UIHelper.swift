//
//  UIHelper.swift
//  Movie
//
//  Created by sayed mansour on 28/09/2024.
//

import UIKit
class UIHelper{
    
    static func createTwoColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minmumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - minmumItemSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
        
        return flowLayout
    }
}
