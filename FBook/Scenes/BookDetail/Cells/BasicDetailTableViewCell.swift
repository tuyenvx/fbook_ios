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
    @IBOutlet fileprivate weak var stackView: UIStackView!
    @IBOutlet fileprivate weak var createdTimeLabel: UILabel!
    @IBOutlet fileprivate weak var viewsLabel: UILabel!

    func updateUI(book: Book) {
        updateRequests(book: book)
        thumbnailImageView.setImage(urlString: book.detail?.media?.first?.thumbnailPath)
        titleLabel.text = book.title
        authorLabel.text = "by \(book.author ?? "")"
        ratingView.rating = book.averageStar
        ratingView.text = "(\(book.detail?.reviews?.count ?? 0))"
        descriptionLabel.text = book.description
        createdTimeLabel.text = TimeFormatter.default.string(from: book.detail?.createdAt ?? Date(),
            outputFormat: kDateFormatYMD)
        viewsLabel.text = "\(book.totalView)"
    }
    private func updateRequests(book: Book) {
        for button in stackView.subviews {
            guard let customActivityButton = button as? CustomActivityButton else {
                return
            }
            switch customActivityButton.tag {
            case BookActivities.review:
                customActivityButton.config("Review", book.detail?.reviews?.count ?? 0)
            case BookActivities.waiting:
                customActivityButton.config("Waiting", book.requests?.waiting?.count ?? 0)
            case BookActivities.reading:
                customActivityButton.config("Reading", book.requests?.reading?.count ?? 0)
            case BookActivities.returning:
                customActivityButton.config("Returning", book.requests?.returning?.count ?? 0)
            case BookActivities.returned:
                customActivityButton.config("Returned", book.requests?.returned?.count ?? 0)
            default:
                print("❌ Error when show button activities")
            }
        }
    }
    @IBAction private func readButtonTapped(_ sender: Any) {
        // TODO: Handle want to read button tapped
    }

    @IBAction private func ownerButtonTapped(_ sender: Any) {
        // TODO: Handle add owner button tapped
    }

}
