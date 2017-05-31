//
//  ItemReviewTableViewCell.swift
//  FBook
//
//  Created by admin on 5/29/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import SwiftyStarRatingView

class ItemReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var ratingView: SwiftyStarRatingView!
    
    class var identifier: String {
        return "ItemReviewTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.nameLabel.text = ""
        self.contentLabel.text = ""
        self.ratingView.value = 0
    }
    
    var review : Review? {
        didSet {
            if let review = review {
                self.nameLabel.text = review.user.name
                self.contentLabel.text = review.content
                self.ratingView.value = CGFloat(review.star)
            }
        }
    }

}
