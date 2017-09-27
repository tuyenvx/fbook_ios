//
//  RatingPresenter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol RatingView: class {

    func showHidePlaceHolder()

}

protocol RatingPresenter {

    func configure(textView: UITextView)
    func sendReview(_ review: Review)

}

class RatingPresenterImplementation: NSObject {

    private(set) var router: RatingViewRouter?
    fileprivate weak var view: RatingView?

    fileprivate var bookId: Int

    init(view: RatingView, router: RatingViewRouter, bookId: Int) {
        self.view = view
        self.router = router
        self.bookId = bookId
    }

}

extension RatingPresenterImplementation: RatingPresenter {

    func configure(textView: UITextView) {
        textView.delegate = self
    }

    func sendReview(_ review: Review) {
        AlertHelper.showLoading()
        BookProvider.reviewBook(bookId: bookId, review: review).on(failed: { _ in
            AlertHelper.hideLoading()
            // TODO: Display error message
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { _ in
            // TODO: Handle write review successfully
        }).start()
    }

}

extension RatingPresenterImplementation: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        view?.showHidePlaceHolder()
    }

}
