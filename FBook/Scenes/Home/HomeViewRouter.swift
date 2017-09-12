//
//  HomeViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

protocol HomeViewRouter {
    func showDetailBook(_ book: Book)
    func showSeeMoreSectionBook(_ sectionBook: SectionBook)
}

struct HomeViewRouterImplementation {

    fileprivate weak var viewController: HomeViewController?

    init(viewController: HomeViewController?) {
        self.viewController = viewController
    }

}

extension HomeViewRouterImplementation: HomeViewRouter {

    func showDetailBook(_ book: Book) {
        // TODO: Show detail book here
    }

    func showSeeMoreSectionBook(_ sectionBook: SectionBook) {
        // TODO: show see more here
    }

}
