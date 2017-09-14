//
//  BookDetailViewController.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class BookDetailViewController: BaseViewController {

    @IBOutlet fileprivate weak var contentView: UIView!
    @IBOutlet fileprivate weak var thumbnailImageView: UIImageView!
    @IBOutlet fileprivate weak var titleLabel: UILabel!
    @IBOutlet fileprivate weak var reviewCountLabel: UILabel!
    @IBOutlet fileprivate weak var readingCountLabel: UILabel!
    @IBOutlet fileprivate weak var ratingView: CosmosView!
    @IBOutlet fileprivate weak var detailTitleLabel: UILabel!
    @IBOutlet fileprivate weak var descriptionLabel: UILabel!
    @IBOutlet fileprivate weak var viewCountLabel: UILabel!
    @IBOutlet fileprivate weak var authorLabel: UILabel!

    var presenter: BookDetailPresenter?
    var configurator: BookDetailConfiguratorImplementation?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.fetchBookDetail()
    }

}

extension BookDetailViewController: BookDetailView {

    func showHideView(_ needToShow: Bool) {
        contentView.isHidden = !needToShow
    }

    func updateUI(detail: BookDetail) {
        thumbnailImageView.setImage(urlString: detail.media?.first?.thumbnailPath)
        titleLabel.text = detail.title
        reviewCountLabel.text = "\(detail.reviews?.count ?? 0) review(s)"
        readingCountLabel.text = "\(detail.usersReading?.count ?? 0) reading(s)"
        ratingView.rating = detail.averageStar
        detailTitleLabel.text = detail.title
        descriptionLabel.text = detail.description
        viewCountLabel.text = "\(detail.totalView)"
        authorLabel.text = detail.author
    }

}
