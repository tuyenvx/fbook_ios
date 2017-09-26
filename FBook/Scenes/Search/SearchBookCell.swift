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
    @IBOutlet fileprivate weak var starIcon: UIImageView!
    @IBOutlet fileprivate weak var viewIcon: UIImageView!

    override func prepareForReuse() {
        super.prepareForReuse()
        photoImageView.kf.cancelDownloadTask()
        photoImageView.image = nil
        nameLabel.text = nil
        authorLabel.text = nil
        viewCountLabel.text = nil
        starLabel.text = nil
        descriptionLabel.text = nil
        starIcon.isHidden = true
        viewIcon.isHidden = true
    }
}

extension SearchBookCell: SearchBookCellView {

    func display(book: Book) {
        photoImageView.setImage(urlString: book.thumbnail, placeHolder: #imageLiteral(resourceName: "img_placeholder_book"))
        nameLabel.text = book.title
        authorLabel.text = book.author
        viewCountLabel.text = "\(book.totalView)"
        starLabel.text = "\(book.averageStar)"
        descriptionLabel.text = book.description
        starIcon.isHidden = false
        viewIcon.isHidden = false
    }

    func display(googleBook: GoogleBook) {
        photoImageView.setImage(urlString: googleBook.thumbnail, placeHolder: #imageLiteral(resourceName: "img_placeholder_book"))
        nameLabel.text = googleBook.title
        authorLabel.text = googleBook.authors.joined(separator: ", ")
        starLabel.text = "\(googleBook.averageRating)"
        descriptionLabel.text = "\(googleBook.description)"
        starIcon.isHidden = false
    }
}
