//
//  WaitingBooksConfigurator.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol WaitingBooksConfigurator {

    func configure(viewController: WaitingBooksViewController)
}

class WaitingBooksConfiguratorImplementation: WaitingBooksConfigurator {

    func configure(viewController: WaitingBooksViewController) {
        let router = WaitingBooksViewRouterImplementation(viewController: viewController)
        let presenter = WaitingBooksPresenterImplementation(view: viewController, router: router)
        viewController.presenter = presenter
    }
}
