//
//  SearchViewRouter.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SearchViewRouter {

    func showDetail(book: Book)
}

class SearchViewRouterImplementation {

    fileprivate var viewController: SearchViewController?

    init(viewController: SearchViewController) {
        self.viewController = viewController
    }
}

extension SearchViewRouterImplementation: SearchViewRouter {

    func showDetail(book: Book) {
        // TODO: Show detail of book
    }
}
