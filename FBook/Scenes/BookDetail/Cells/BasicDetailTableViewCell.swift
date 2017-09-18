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

    func updateUI(book: Book) {
        thumbnailImageView.setImage(urlString: book.detail?.media?.first?.thumbnailPath)
        titleLabel.text = book.title
        authorLabel.text = "by \(book.author ?? "")"
        ratingView.rating = book.averageStar
        ratingView.text = "(\(book.detail?.reviews?.count ?? 0))"
        descriptionLabel.text = book.description
        pagesLabel.text = "\(book.totalPage)"
        createdTimeLabel.text = TimeFormatter.default.string(from: book.detail?.createdAt ?? Date(),
            outputFormat: kDateServerFormat)
        viewsLabel.text = "\(book.totalView)"
    }

}
