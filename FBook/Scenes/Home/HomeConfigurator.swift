//
//  HomeConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

protocol HomeConfigurator {
    func configure(viewController: HomeViewController)
}

struct HomeConfiguratorImplementation {

}

extension HomeConfiguratorImplementation: HomeConfigurator {

    func configure(viewController: HomeViewController) {
        let router = HomeViewRouterImplementation(viewController: viewController)
        let presenter = HomePresenterImplementation(view: viewController, router: router)
        viewController.presenter = presenter
    }

}
