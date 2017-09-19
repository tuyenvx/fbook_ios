//
//  LoginViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol LoginViewRouter {
    func dismiss()
    func presentForgotPassword()
    func showTabBarController()
}

struct LoginViewRouterImplementation {

    fileprivate weak var loginViewController: LoginViewController?

    init(loginViewController: LoginViewController?) {
        self.loginViewController = loginViewController
    }

}

extension LoginViewRouterImplementation: LoginViewRouter {

    func dismiss() {
        loginViewController?.dismiss(animated: true, completion: nil)
    }

    func presentForgotPassword() {
        let forgotPasswordVC = ForgotPasswordViewController()
        forgotPasswordVC.forgotPasswordConfigurator = ForgotPasswordConfiguratorImplementation()
        loginViewController?.present(forgotPasswordVC, animated: true, completion: nil)
    }

    func showTabBarController() {
        loginViewController?.dismiss(animated: false, completion: { 
            application.keyWindow?.rootViewController = UIStoryboard.home.instantiateInitialViewController()
        })
    }

}
