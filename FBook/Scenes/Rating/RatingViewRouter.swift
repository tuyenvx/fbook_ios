//
//  RatingViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/19/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol RatingViewRouter {

}

class RatingViewRouterImplementation {

    fileprivate weak var viewController: RatingViewController?

    init(viewController: RatingViewController) {
        self.viewController = viewController
    }

}

extension RatingViewRouterImplementation: RatingViewRouter {

}
