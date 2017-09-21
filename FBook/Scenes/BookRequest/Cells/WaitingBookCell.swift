//
//  BookWaitingCell.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class WaitingBookCell: UITableViewCell {

    @IBOutlet fileprivate weak var bookPhoto: UIImageView!
    @IBOutlet fileprivate weak var ownersLabel: UILabel!
    @IBOutlet fileprivate weak var nameLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var ratingView: CosmosView!
    weak var presenter: WaitingBooksPresenter?

    @IBAction fileprivate func onViewAllRequestTapped(_ sender: UIButton) {
        presenter?.showAllRequest(for: self)
    }

    func configure(_ book: Book) {
        bookPhoto.setImage(urlString: book.thumbnail, placeHolder: #imageLiteral(resourceName: "img_placeholder_book"))
        nameLabel.text = book.title
        authorLabel.text = book.author
        descriptionLabel.text = book.description
        ratingView.rating = book.averageStar
        var listOwners = ""
        if let owners = book.requests?.owners {
            for owner in owners {
                if listOwners == "" {
                    listOwners += owner.name
                } else {
                    listOwners += ", \(owner.name)"
                }
            }
        }
        ownersLabel.text = "Shared by: \(listOwners)"
    }
}
