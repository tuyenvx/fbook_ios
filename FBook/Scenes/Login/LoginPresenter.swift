//
//  LoginPresenter.swift
//  FBook
//
//  Created by Nguyen Ngoc Ban on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import ReactiveSwift
import RxSwift

protocol LoginView: class {
    func endEditing()
    func showLoginSuccessful()
    func showLoginError(message: String)
}

protocol LoginPresenter {
    var router: LoginViewRouter? { get }
    func login(email: String, password: String)
    func didSelectClose()
    func didSelectForgotPassword()
    func openTabBarController()
}

class LoginPresenterImplementation {

    private(set) var router: LoginViewRouter?
    fileprivate weak var view: LoginView?

    init(view: LoginView, router: LoginViewRouter?) {
        self.view = view
        self.router = router
    }

}

extension LoginPresenterImplementation: LoginPresenter {

    func login(email: String, password: String) {
        view?.endEditing()
        AlertHelper.showLoading()
        weak var weakSelf = self
        AuthenticationProvider.login(email: email, password: password).on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.view?.showLoginError(message: error.message)
        }, completed: {
        }, value: { accessToken in
            ApiProvider.accessToken = accessToken
            UsersProvider.getUserProfile().on(failed: { error in
                AlertHelper.hideLoading()
                weakSelf?.view?.showLoginError(message: error.message)
            }, completed: {
            }, value: { user in
                User.currentUser = user
                AlertHelper.hideLoading()
                weakSelf?.view?.showLoginSuccessful()
            }).start()
        }).start()
    }

    func didSelectClose() {
        router?.dismiss()
    }

    func didSelectForgotPassword() {
        view?.endEditing()
        router?.presentForgotPassword()
    }

    func openTabBarController() {
        router?.showTabBarController()
    }

}
