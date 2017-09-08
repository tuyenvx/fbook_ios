//
//  ForgotPasswordViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    var forgotPasswordPresenter: ForgotPasswordPresenter?
    var forgotPasswordConfigurator: ForgotPasswordConfiguratorImplementation?

    override func viewDidLoad() {
        super.viewDidLoad()
        forgotPasswordConfigurator?.configure(forgotPasswordViewController: self)
    }

    @IBAction fileprivate func backButtonTapped(_ sender: Any) {
        forgotPasswordPresenter?.cancelButtonPressed()
    }

}

extension ForgotPasswordViewController: ForgotPasswordView {
}
