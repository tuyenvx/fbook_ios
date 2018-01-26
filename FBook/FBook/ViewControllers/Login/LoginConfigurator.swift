//
//  LoginConfigurator.swift
//  FBook
//
//  Created by TuyenVX on 1/26/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
protocol LoginConfiturator {
    func configure(loginViewController: LoginViewController)
}

class LoginConfituratorImplementation: LoginConfiturator {
    func configure(loginViewController: LoginViewController) {
        let presenter = LoginPresensterImplementation(view: loginViewController)
        loginViewController.presenter = presenter
    }
}
