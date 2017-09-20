//
//  FollowingConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol FollowingConfigurator {
    func configure()
}

class FollowingConfiguratorImplementation: FollowingConfigurator {

    fileprivate let followingViewController: FollowingViewController
    fileprivate var user: User

    init(user: User, viewController: FollowingViewController) {
        self.user = user
        self.followingViewController = viewController
    }

    func configure() {
        let router = FollowingRouterImplementation(view: followingViewController)
        let presenter = FollowingPresenterImplementation(view: followingViewController, router: router, user: user)
        followingViewController.presenter = presenter
    }
}
