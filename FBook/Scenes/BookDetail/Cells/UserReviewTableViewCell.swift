//
//  UserReviewTableViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class UserReviewTableViewCell: UITableViewCell {

    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var fullNameLabel: UILabel!
    @IBOutlet private weak var ratingView: CosmosView!
    @IBOutlet private weak var reviewedTimeLabel: UILabel!
    @IBOutlet private weak var reviewContentLabel: UILabel!

    func updateUI(review: Review) {
        avatarImageView.setImage(urlString: review.user?.avatar, placeHolder: kDefaultAvatar)
        fullNameLabel.text = review.user?.name
        ratingView.rating = Double(review.star)
        reviewedTimeLabel.text = TimeFormatter.default.string(from: review.createdAt ?? Date(),
            outputFormat: kDateServerFormat)
        reviewContentLabel.text = review.content
    }

}
