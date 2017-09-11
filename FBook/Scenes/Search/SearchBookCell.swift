//
//  SearchBookCell.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Kingfisher

class SearchBookCell: UITableViewCell {

    @IBOutlet fileprivate weak var photoImageView: UIImageView!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var viewCountLabel: UILabel!
    @IBOutlet fileprivate weak var starLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.image = nil
        nameLabel.text = nil
        authorLabel.text = nil
        viewCountLabel.text = nil
        starLabel.text = nil
        descriptionLabel.text = nil
    }
}

extension SearchBookCell: SearchBookCellView {

    func display(book: Book?) {
        if let urlString = book?.thumbnail, let url = URL(string: urlString) {
            photoImageView.kf.setImage(with: url)
        } else {
            photoImageView.kf.cancelDownloadTask()
            photoImageView.image = nil
        }
        nameLabel.text = book?.title
        authorLabel.text = book?.author
        viewCountLabel.text = "\(book?.totalView ?? 0)"
        starLabel.text = "\(book?.averageStar ?? 0.0)"
        descriptionLabel.text = book?.description
    }
}
