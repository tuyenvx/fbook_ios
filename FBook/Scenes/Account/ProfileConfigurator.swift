//
//  ProfileConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ProfileConfigurator {
    func configure(profileViewController: ProfileViewController)
}

class ProfileConfiguratorImplementation: ProfileConfigurator {

    func configure(profileViewController: ProfileViewController) {
        let presenter = ProfilePresenterImplementation(view: profileViewController)
        profileViewController.presenter = presenter
    }
}
