//
//  AccountConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol AccountConfigurator {
    func configure(accountViewController: AccountViewController, user: User)
}

class AccountConfiguratorImplementation: AccountConfigurator {

    func configure(accountViewController: AccountViewController, user: User) {
        let router = AccountRouterImplementation(accountViewController: accountViewController)
        let presenter = AccountPresenterImplementation(view: accountViewController, router: router)
        presenter.user = user
        accountViewController.presenter = presenter
    }
}
