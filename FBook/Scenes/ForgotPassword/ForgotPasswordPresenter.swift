//
//  ForgotPasswordPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ForgotPasswordView: class {
}

protocol ForgotPasswordPresenter {
    var router: ForgotPasswordViewRouter? { get }
    func cancelButtonPressed()
}

class ForgotPasswordPresenterImplementation {

    fileprivate weak var view: ForgotPasswordView?
    private(set) var router: ForgotPasswordViewRouter?

    init(view: ForgotPasswordView, router: ForgotPasswordViewRouter) {
        self.view = view
        self.router = router
    }

}

extension ForgotPasswordPresenterImplementation: ForgotPasswordPresenter {

    func cancelButtonPressed() {
        router?.dismiss()
    }

}
