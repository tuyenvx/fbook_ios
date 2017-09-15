//
//  BasicDetailTableViewCell.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class BasicDetailTableViewCell: UITableViewCell {

    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var ratingView: CosmosView!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var pagesLabel: UILabel!
    @IBOutlet fileprivate weak var createdTimeLabel: UILabel!
    @IBOutlet fileprivate weak var viewsLabel: UILabel!

    func updateUI(detail: BookDetail) {
        thumbnailImageView.setImage(urlString: detail.media?.first?.thumbnailPath)
        titleLabel.text = detail.title
        authorLabel.text = "by \(detail.author ?? "")"
        ratingView.rating = detail.averageStar
        ratingView.text = "(\(detail.reviews?.count ?? 0))"
        descriptionLabel.text = detail.description
        pagesLabel.text = "\(detail.totalPage)"
        createdTimeLabel.text = TimeFormatter.default.string(from: detail.createdAt ?? Date(),
            outputFormat: kDateServerFormat)
        viewsLabel.text = "\(detail.totalView)"
    }

}
