//
//  CategoryPickerConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol CategoryPickerConfigurator {
    func configure(viewController: CategoryPickerViewController)
}

struct CategoryPickerConfiguratorImplementation {

    fileprivate weak var delegate: CategoryPickerPresenterDelegate?
    fileprivate let currentCategory: Category?

    init(delegate: CategoryPickerPresenterDelegate?, currentCategory: Category?) {
        self.delegate = delegate
        self.currentCategory = currentCategory
    }
}

extension CategoryPickerConfiguratorImplementation: CategoryPickerConfigurator {

    func configure(viewController: CategoryPickerViewController) {
        let router = CategoryPickerRouterImplementation(viewController: viewController)
        let presenter = CategoryPickerPresenterImplementation(view: viewController, router: router, delegate: delegate,
            currentSelectedCategory: currentCategory)
        viewController.presenter = presenter
    }

}
