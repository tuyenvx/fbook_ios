//
//  AccountConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol AccountConfigurator {
    func configure(viewController: AccountViewController)
}

class AccountConfiguratorImplementation: AccountConfigurator {
    fileprivate var user: User

    init(user: User) {
        self.user = user
    }

    func configure(viewController: AccountViewController) {
        let router = AccountRouterImplementation(viewController: viewController)
        let presenter = AccountPresenterImplementation(view: viewController, router: router, user: user)
        viewController.presenter = presenter

    }
}
