//
//  WaitingRequestViewRouter.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol WaitingRequestViewRouter {

    func showAllRequest(for book: Book)
}

class WaitingRequestViewRouterImplementation {

    fileprivate var viewController: WaitingRequestViewController?

    init(viewController: WaitingRequestViewController) {
        self.viewController = viewController
    }
}

extension WaitingRequestViewRouterImplementation: WaitingRequestViewRouter {

    func showAllRequest(for book: Book) {
        // TODO: Go to all request screen
    }
}
