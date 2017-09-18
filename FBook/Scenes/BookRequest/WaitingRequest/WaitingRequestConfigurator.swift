//
//  WaitingRequestConfigurator.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol WaitingRequestConfigurator {

    func configure(viewController: WaitingRequestViewController)
}

class WaitingRequestConfiguratorImplementation: WaitingRequestConfigurator {

    func configure(viewController: WaitingRequestViewController) {
        let router = WaitingRequestViewRouterImplementation(viewController: viewController)
        let presenter = WaitingRequestPresenterImplementation(view: viewController, router: router)
        viewController.presenter = presenter
    }
}
