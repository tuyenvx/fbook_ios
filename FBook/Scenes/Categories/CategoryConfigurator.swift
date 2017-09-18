//
//  CategoryConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol CategoryConfigurator {
    func configure(view: CategoryViewController)
}

struct CategoryConfiguratorImplementation {

    fileprivate let category: Category?

    init(category: Category?) {
        self.category = category
    }
}

extension CategoryConfiguratorImplementation: CategoryConfigurator {

    func configure(view: CategoryViewController) {
        let router = CategoryRouterImplementation(view: view)
        let presenter = CategoryPresenterImplementation(view: view, router: router)
        presenter.setCategory(category)
        view.presenter = presenter
    }

}
