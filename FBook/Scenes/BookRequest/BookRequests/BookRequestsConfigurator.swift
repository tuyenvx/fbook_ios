//
//  BookRequestsConfigurator.swift
//  FBook
//
//  Created by Huy Pham on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookRequestsConfigurator {

    func configure(viewController: BookRequestsViewController)
}

class BookRequestsConfiguratorImplementation: BookRequestsConfigurator {

    let book: Book

    init(book: Book) {
        self.book = book
    }

    func configure(viewController: BookRequestsViewController) {
        let router = BookRequestsViewRouterImplementation(viewController: viewController)
        let presenter = BookRequestsPresenterImplementation(view: viewController, router: router, book: book)
        viewController.presenter = presenter
    }
}
