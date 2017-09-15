//
//  SectionBookRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol SectionBookRouter {
    func showBookDetail(book: Book)
}

struct SectionBookRouterImplementation {

    fileprivate weak var viewController: SectionBookViewController?
    init(viewController: SectionBookViewController?) {
        self.viewController = viewController
    }

}

extension SectionBookRouterImplementation: SectionBookRouter {

    func showBookDetail(book: Book) {
        guard let detailViewController = UIStoryboard.bookDetail.instantiateInitialViewController()
                as? BookDetailViewController else {
            return
        }
        detailViewController.configurator = BookDetailConfiguratorImplementation(book: book)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }

}
