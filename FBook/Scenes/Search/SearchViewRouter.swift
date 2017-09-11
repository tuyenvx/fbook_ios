//
//  SearchViewRouter.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SearchViewRouter {
}

class SearchViewRouterImplementation: SearchViewRouter {

    fileprivate var viewController: SearchViewController?

    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
}
