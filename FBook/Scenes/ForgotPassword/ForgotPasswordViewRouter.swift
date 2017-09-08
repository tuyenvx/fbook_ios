//
//  ForgotPasswordViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ForgotPasswordViewRouter {
    func dismiss()
}

struct ForgotPasswordViewRouterImplementation {

    fileprivate weak var forgotPasswordViewController: ForgotPasswordViewController?

    init(controller: ForgotPasswordViewController) {
        forgotPasswordViewController = controller
    }

}

extension ForgotPasswordViewRouterImplementation: ForgotPasswordViewRouter {

    func dismiss() {
        forgotPasswordViewController?.dismiss(animated: true, completion: nil)
    }

}
