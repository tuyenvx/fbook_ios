//
//  BookDetailViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol BookDetailViewRouter {

    func presentRatingViewController()
    func presentLoginViewController()

}

class BookDetailViewRouterImplementation {

    fileprivate weak var viewController: BookDetailViewController?

    init(viewController: BookDetailViewController) {
        self.viewController = viewController
    }

}

extension BookDetailViewRouterImplementation: BookDetailViewRouter {

    func presentRatingViewController() {
        viewController?.performSegue(withIdentifier: "rating", sender: self)
    }

    func presentLoginViewController() {
        viewController?.performSegue(withIdentifier: "login", sender: self)
    }

}
