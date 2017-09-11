//
//  SearchConfigurator.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SearchConfigurator: class {

    func configure(viewController: SearchViewController)
}

class SearchConfiguratorImplementation: SearchConfigurator {

    func configure(viewController: SearchViewController) {
        let router = SearchViewRouterImplementation(viewController: viewController)
        let presenter = SearchPresenterImplementation(view: viewController, router: router)
        viewController.presenter = presenter
    }
}
