//
//  CategoryRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryRouter {

    func showBookDetail(_ book: Book)
}

struct CategoryRouterImplementation {

    fileprivate weak var view: CategoryViewController?

    init(view: CategoryViewController) {
        self.view = view
    }

}

extension CategoryRouterImplementation: CategoryRouter {

    func showBookDetail(_ book: Book) {
        guard let detailViewController = UIStoryboard.bookDetail.instantiateInitialViewController()
                as? BookDetailViewController else {
            return
        }
        detailViewController.configurator = BookDetailConfiguratorImplementation(book: book)
        view?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
