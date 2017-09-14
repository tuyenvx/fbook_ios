//
//  BookDetailConfigurator.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookDetailConfigurator: class {

    func configure(viewController: BookDetailViewController)

}

class BookDetailConfiguratorImplementation: BookDetailConfigurator {

    let book: Book

    init(book: Book) {
        self.book = book
    }

    func configure(viewController: BookDetailViewController) {
        let router = BookDetailViewRouterImplementation(viewController: viewController)
        let presenter = BookDetailPresenterImplementation(view: viewController, router: router, book: book)
        viewController.presenter = presenter
    }

}
