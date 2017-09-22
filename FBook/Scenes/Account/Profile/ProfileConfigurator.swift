//
//  ProfileConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ProfileConfigurator {
    func configure()
}

class ProfileConfiguratorImplementation: ProfileConfigurator {
    fileprivate let profileViewController: ProfileViewController
    fileprivate var user: User

    init(user: User, viewController: ProfileViewController) {
        self.user = user
        self.profileViewController = viewController
    }

    func configure() {
        let presenter = ProfilePresenterImplementation(view: profileViewController, user: user)
        profileViewController.presenter = presenter
    }
}
