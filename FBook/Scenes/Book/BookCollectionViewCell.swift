//
//  BookCollectionViewCell.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Kingfisher

class BookCollectionViewCell: UICollectionViewCell {

    static func fitSizeItem(withSize size: CGSize) -> CGSize {
        let beautyWidth: CGFloat = 120
        let space: CGFloat = 10
        let numberCollum = Int((size.width - 2 * space) / beautyWidth)
        let widthCell = (size.width - space) / CGFloat(numberCollum) - 10
        return CGSize(width: widthCell, height: widthCell * 1.3 + 30)
    }

    var presenter: BookCellPresenter?
    var configurator: BookCellConfigurator?

    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    @IBOutlet fileprivate weak var totalViewLabel: UILabel!
    @IBOutlet fileprivate weak var starLabel: UILabel!

}

extension BookCollectionViewCell: BookCellView {

    func displayConfigurator(_ configurator: BookCellConfigurator) {
        self.configurator = configurator
        self.configurator?.configure(cell: self)
        presenter?.loadBook()
    }

    func displayBook(book: Book) {
        nameLabel.text = book.title
        starLabel.text = String(format: "%.01f", book.averageStar)
        totalViewLabel.text = book.totalView.description
        thumbnailImageView.setImage(urlString: book.thumbnail)
    }

}
