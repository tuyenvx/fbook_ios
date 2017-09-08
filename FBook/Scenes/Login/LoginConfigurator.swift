//
//  LoginConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol LoginConfigurator {
    func configure(loginViewController: LoginViewController)
}

struct LoginConfiguratorImplementation {
}

extension LoginConfiguratorImplementation: LoginConfigurator {

    func configure(loginViewController: LoginViewController) {
        let router = LoginViewRouterImplementation(loginViewController: loginViewController)
        let presenter = LoginPresenterImplementation(view: loginViewController, router: router)
        loginViewController.loginPresenter = presenter
    }

}
