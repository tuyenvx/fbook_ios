//
//  ItemSectionBooksTableViewCell.swift
//  FBook
//
//  Created by admin on 5/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ItemSectionBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    class var identifier: String {
        return "ItemSectionBooksTableViewCell"
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.register(UINib(nibName: ItemBookCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: ItemBookCollectionViewCell.identifier)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
