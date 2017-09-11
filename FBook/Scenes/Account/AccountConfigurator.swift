//
//  AccountConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol AccountConfigurator {
    func configure(accountViewController: AccountViewController)
}

class AccountConfiguratorImplementation: AccountConfigurator {

    func configure(accountViewController: AccountViewController) {
        let presenter = AccountPresenterImplementation(view: accountViewController)
        accountViewController.presenter = presenter
    }
}
