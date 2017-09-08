//
//  ForgotPasswordConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ForgotPasswordConfigurator {
    func configure(forgotPasswordViewController: ForgotPasswordViewController)
}

struct ForgotPasswordConfiguratorImplementation {
}

extension ForgotPasswordConfiguratorImplementation: ForgotPasswordConfigurator {

    func configure(forgotPasswordViewController: ForgotPasswordViewController) {
        let router = ForgotPasswordViewRouterImplementation(controller: forgotPasswordViewController)
        let presenter = ForgotPasswordPresenterImplementation(view: forgotPasswordViewController, router: router)
        forgotPasswordViewController.forgotPasswordPresenter = presenter
    }

}
