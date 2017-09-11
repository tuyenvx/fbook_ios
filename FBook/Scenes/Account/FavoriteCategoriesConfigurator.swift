//
//  FavoriteCategoriesConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol FavoriteCategoriesConfigurator {
    func configure(viewController: FavoriteCategoriesViewController)
}

class FavoriteCategoriesConfiguratorImplementation: FavoriteCategoriesConfigurator {

    func configure(viewController: FavoriteCategoriesViewController) {
        let presenter = FavoriteCategoriesPresenterImplementation(view: viewController)
        viewController.presenter = presenter
    }
}
