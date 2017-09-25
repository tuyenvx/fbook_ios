//
//  ShareBookConfigurator.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ShareBookConfigurator: class {

    func configure(viewController: ShareBookViewController)

}

class ShareBookConfiguratorImpl: ShareBookConfigurator {

    func configure(viewController: ShareBookViewController) {
        let router = ShareBookViewRouterImpl(viewController: viewController)
        let presenter = ShareBookPresenterImpl(view: viewController, router: router)
        viewController.presenter = presenter
    }

}
