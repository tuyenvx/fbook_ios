//
//  ItemBookCollectionViewCell.swift
//  FBook
//
//  Created by admin on 5/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Kingfisher

class ItemBookCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var thumbImageView: UIImageView!
    
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.authorLabel.text = ""
        self.thumbImageView.image = #imageLiteral(resourceName: "thumb_book")
    }

    var book : Book? {
        didSet {
            if let book = book {
                self.titleLabel.text = book.title
                self.authorLabel.text = book.author
                if let url = URL(string: book.thumbnail) {
                    self.thumbImageView.kf.setImage(with: url, options: [KingfisherOptionsInfoItem.cacheMemoryOnly]);
                }
            }
        }
    }
    
}
