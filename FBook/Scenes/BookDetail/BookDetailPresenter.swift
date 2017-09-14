//
//  BookDetailPresenter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookDetailView: class {

    func showHideView(_ needToShow: Bool)
    func updateUI(detail: BookDetail)

}

protocol BookDetailPresenter {

    func fetchBookDetail()

}

class BookDetailPresenterImplementation {

    private(set) var router: BookDetailViewRouter?
    fileprivate weak var view: BookDetailView?

    fileprivate let book: Book

    init(view: BookDetailView, router: BookDetailViewRouter, book: Book) {
        self.view = view
        self.router = router
        self.book = book
    }

}

extension BookDetailPresenterImplementation: BookDetailPresenter {

    func fetchBookDetail() {
        AlertHelper.showLoading()
        weak var weakSelf = self
        BookProvider.getBookDetail(bookId: book.id).on(starting: {
            weakSelf?.view?.showHideView(false)
        }, failed: { _ in
            AlertHelper.hideLoading()
            // TODO: Handle error when fetch book detail failed
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { bookDetail in
            weakSelf?.view?.showHideView(true)
            weakSelf?.view?.updateUI(detail: bookDetail)
        }).start()
    }

}
