//
//  RatingConfigurator.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol RatingConfigurator {

    func configure(viewController: RatingViewController)

}

class RatingConfiguratorImplementation: RatingConfigurator {

    let bookId: Int

    init(bookId: Int) {
        self.bookId = bookId
    }

    func configure(viewController: RatingViewController) {
        let router = RatingViewRouterImplementation(viewController: viewController)
        let presenter = RatingPresenterImplementation(view: viewController, router: router, bookId: bookId)
        viewController.presenter = presenter
    }

}
