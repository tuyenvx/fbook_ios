//
//  RatingViewController.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import Cosmos

class RatingViewController: BaseViewController {

    @IBOutlet fileprivate weak var ratingView: CosmosView!
    @IBOutlet fileprivate weak var reviewTextView: UITextView!
    @IBOutlet fileprivate weak var placeHolderLabel: UILabel!

    var presenter: RatingPresenter?
    var configurator: RatingConfiguratorImplementation?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator?.configure(viewController: self)
        presenter?.configure(textView: reviewTextView)
        reviewTextView.becomeFirstResponder()
    }

    fileprivate func getReview() -> Review? {
        guard ratingView.rating > 0.0, let star = Int(exactly: ratingView.rating) else {
            Utility.shared.showMessage(message: "Tap a star to rate.")
            return nil
        }
        if reviewTextView.text.isEmpty {
            Utility.shared.showMessage(message: "Please enter your review.")
            reviewTextView.becomeFirstResponder()
            return nil
        }
        var review = Review()
        review.content = reviewTextView.text
        review.star = star
        return review
    }

    @IBAction func cancelButtonTapped(_ sender: Any) {
        cancelButtonTapped()
    }

    @IBAction func sendReviewButtonTapped(_ sender: Any) {
        if let review = getReview() {
            view.endEditing(true)
            presenter?.sendReview(review)
        }
    }

}

extension RatingViewController: RatingView {

    func showHidePlaceHolder() {
        placeHolderLabel.isHidden = reviewTextView.hasText
    }

}
