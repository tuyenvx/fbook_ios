//
//  SortBookConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SortBookConfigurator {
    func configure(viewController: SortBookViewController)
}

struct SortBookConfiguratorImplementation {

    fileprivate weak var delegate: SortBookPresenterDelegate?
    fileprivate let currentSort: SortType

    init(delegate: SortBookPresenterDelegate?, currentSort: SortType) {
        self.delegate = delegate
        self.currentSort = currentSort
    }
}

extension SortBookConfiguratorImplementation: SortBookConfigurator {

    func configure(viewController: SortBookViewController) {
        let router = SortBookRouterImplementation(viewController: viewController)
        let presenter = SortBookPresenterImplementation(view: viewController, router: router, delegate: delegate,
            currentSelectedSort: currentSort)
        viewController.presenter = presenter
    }

}
