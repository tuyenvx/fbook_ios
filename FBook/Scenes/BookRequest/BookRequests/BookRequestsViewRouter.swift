//
//  BookRequestsViewRouter.swift
//  FBook
//
//  Created by Huy Pham on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BookRequestsViewRouter {
}

class BookRequestsViewRouterImplementation: BookRequestsViewRouter {

    fileprivate var viewController: BookRequestsViewController

    init(viewController: BookRequestsViewController) {
        self.viewController = viewController
    }
}
