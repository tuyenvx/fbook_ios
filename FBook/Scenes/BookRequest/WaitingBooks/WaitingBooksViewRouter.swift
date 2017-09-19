//
//  WaitingBooksViewRouter.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol WaitingBooksViewRouter {

    func showAllRequest(for book: Book)
}

class WaitingBooksViewRouterImplementation {

    fileprivate var viewController: WaitingBooksViewController?

    init(viewController: WaitingBooksViewController) {
        self.viewController = viewController
    }
}

extension WaitingBooksViewRouterImplementation: WaitingBooksViewRouter {

    func showAllRequest(for book: Book) {
        // TODO: Go to all request screen
    }
}
