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
    func showLoginResult(user: User?, error: Error?)
}

struct LoginPresenter {

    unowned let view: LoginView

    func login(email: String, password: String) {
        AuthenticationProvider.login(email: email, password: password).on(failed: { error in
            self.view.showLoginResult(user: nil, error: error)
        }, completed: {
        }, value: { accessToken in
            ApiProvider.accessToken = accessToken
            UsersProvider.getUserProfile().on(failed: { error in
                self.view.showLoginResult(user: nil, error: error)
            }, completed: {
            }, value: { user in
                User.currentUser = user
                self.view.showLoginResult(user: user, error: nil)
            }).start()
        }).start()
    }

}
