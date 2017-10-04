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
    func showCategoryPicker(delegate: CategoryPickerPresenterDelegate, currentCategory: Category?)
    func showSortBook(delegate: SortBookPresenterDelegate, currentSort: SortType)
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

    func showCategoryPicker(delegate: CategoryPickerPresenterDelegate, currentCategory: Category?) {
        let categoryPicker = CategoryPickerViewController(nibName: "CategoryPickerViewController", bundle: nil)
        categoryPicker.configurator = CategoryPickerConfiguratorImplementation(delegate: delegate,
            currentCategory: currentCategory)
        categoryPicker.modalPresentationStyle = .overFullScreen
        viewController?.present(categoryPicker, animated: false, completion: nil)
    }

    func showSortBook(delegate: SortBookPresenterDelegate, currentSort: SortType) {
        let sortBookPicker = SortBookViewController(nibName: "SortBookViewController", bundle: nil)
        sortBookPicker.configurator = SortBookConfiguratorImplementation(delegate: delegate, currentSort: currentSort)
        sortBookPicker.modalPresentationStyle = .overFullScreen
        viewController?.present(sortBookPicker, animated: false, completion: nil)
    }
}
