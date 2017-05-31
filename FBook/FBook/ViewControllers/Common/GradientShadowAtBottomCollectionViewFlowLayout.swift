//
//  GradientShadowAtBottomCollectionViewFlowLayout.swift
//  FBook
//
//  Created by admin on 5/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class GradientShadowAtBottomCollectionViewFlowLayout: UICollectionViewFlowLayout {

    let kGradientKind = "Gradient"
    
    override func prepare() {
        self.register(GradientCollectionReusableView.self, forDecorationViewOfKind: kGradientKind)
    }
    
    override func layoutAttributesForDecorationView(ofKind elementKind: String, at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {

        let cellAttributes: UICollectionViewLayoutAttributes? = layoutAttributesForItem(at: indexPath)
        
        let layoutAttributes = UICollectionViewLayoutAttributes(forDecorationViewOfKind: elementKind, with: indexPath)
        
        if let baseFrame = cellAttributes?.frame,
            elementKind == kGradientKind {
            // Positions the horizontal line for this item.
            layoutAttributes.frame = CGRect(x: 0,
                                            y: baseFrame.origin.y,
                                            width: screenWidth(with: UIApplication.shared.statusBarOrientation),
                                            height: baseFrame.size.height)
        }
        layoutAttributes.zIndex = -1
        return layoutAttributes
    }
        
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let baseLayoutAttributes = super.layoutAttributesForElements(in: rect)
        if let baseLayoutAttributes = baseLayoutAttributes {
            var layoutAttributes = baseLayoutAttributes
            for thisLayoutItem in baseLayoutAttributes {
                if thisLayoutItem.representedElementCategory == .cell {
                    // Adds horizontal lines when the item in the first line.
                    if indexPathFirst(inRow: thisLayoutItem.indexPath),
                        let newHorizontalLayoutItem = layoutAttributesForDecorationView(ofKind: kGradientKind, at: thisLayoutItem.indexPath) {
                        layoutAttributes.append(newHorizontalLayoutItem)
                    }
                }
            }
            return layoutAttributes
        }
        return baseLayoutAttributes
    }
    
    func indexPathFirst(inRow indexPath: IndexPath) -> Bool {
        let previousIndexPath = IndexPath(item: indexPath.row - 1, section: indexPath.section)
        if let cellAttributes = layoutAttributesForItem(at: indexPath),
            let previousCellAttributes = layoutAttributesForItem(at: previousIndexPath) {
            return (cellAttributes.frame.origin.y != previousCellAttributes.frame.origin.y || indexPath.row == 0)
        }
        return false
    }
    
    func indexPathLast(inSection indexPath: IndexPath) -> Bool {
        if let collectionView = collectionView,
            let numberOfItemsInSection = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: indexPath.section) {
            let lastItem = numberOfItemsInSection - 1
            return lastItem == indexPath.row
        }
        return false
    }
    
    func indexPath(inLastLine indexPath: IndexPath) -> Bool {
        if let collectionView = collectionView,
            let numberOfItemsInSection = collectionView.dataSource?.collectionView(collectionView, numberOfItemsInSection: indexPath.section) {
            
            let lastItemRow = numberOfItemsInSection - 1
            let lastItem = IndexPath(item: lastItemRow, section: indexPath.section)
            if let lastItemAttributes = layoutAttributesForItem(at: lastItem), let thisItemAttributes = layoutAttributesForItem(at: indexPath) {
                return lastItemAttributes.frame.origin.y == thisItemAttributes.frame.origin.y
            }
            
            return false
        }
        return false
    }
    
    func indexPathLast(inLine indexPath: IndexPath) -> Bool {
        let nextIndexPath = IndexPath(item: indexPath.row + 1, section: indexPath.section)
        if let cellAttributes = layoutAttributesForItem(at: indexPath),
            let nextCellAttributes = layoutAttributesForItem(at: nextIndexPath) {
            return !(cellAttributes.frame.origin.y == nextCellAttributes.frame.origin.y)
        }
        return false
    }
    
    func screenWidth(with orientation: UIInterfaceOrientation) -> CGFloat {
        return UIScreen.main.bounds.size.width
    }

}
