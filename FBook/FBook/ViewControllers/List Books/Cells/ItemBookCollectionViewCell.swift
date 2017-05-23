//
//  ItemBookCollectionViewCell.swift
//  FBook
//
//  Created by admin on 5/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ItemBookCollectionViewCell: UICollectionViewCell {

    class var identifier: String {
        return "ItemBookCollectionViewCell"
    }
    
    class var size: CGSize {
        return CGSize.init(width: 100, height: 180)
    }
    
    class var spaceForItem: CGFloat {
        return 15
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    
}
