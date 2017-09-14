//
//  BookDetailViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookDetailViewRouter {

    func presentRatingViewController()

}

class BookDetailViewRouterImplementation {

    fileprivate weak var viewController: BookDetailViewController?

    init(viewController: BookDetailViewController) {
        self.viewController = viewController
    }

}

extension BookDetailViewRouterImplementation: BookDetailViewRouter {

    func presentRatingViewController() {
        // TODO: Present rating view controller
    }

}
