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
        guard let detailViewController = UIStoryboard.bookDetail.instantiateInitialViewController()
                as? BookDetailViewController else {
            return
        }
        detailViewController.configurator = BookDetailConfiguratorImplementation(book: book)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }

    func showSeeMoreSectionBook(_ sectionBook: SectionBook) {
        guard let sectionBookViewController = UIStoryboard.home
                .instantiateViewController(withIdentifier: "SectionBookViewController")
                as? SectionBookViewController else {
            return
        }
        sectionBookViewController.configurator = SectionBookConfiguratorImplementation(sectionBook: sectionBook)
        viewController?.navigationController?.pushViewController(sectionBookViewController, animated: true)
    }

}
