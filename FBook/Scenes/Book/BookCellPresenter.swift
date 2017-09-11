//
//  BookCellPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookCellView: class {
    func displayConfigurator(_ configurator: BookCellConfigurator)
    func displayBook(book: Book)
}

protocol BookCellPresenter {
    func loadBook()
}

struct BookCellPresenterImplementation {

    fileprivate weak var view: BookCellView?
    fileprivate var book: Book

    init(view: BookCellView?, book: Book) {
        self.view = view
        self.book = book
    }

}

extension BookCellPresenterImplementation: BookCellPresenter {

    func loadBook() {
        view?.displayBook(book: book)
    }

}
