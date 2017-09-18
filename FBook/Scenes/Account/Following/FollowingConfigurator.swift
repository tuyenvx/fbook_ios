//
//  FollowingConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol FollowingConfigurator {
    func configure(followingViewCotroller: FollowingViewController)
}

class FollowingConfiguratorImplementation: FollowingConfigurator {
    func configure(followingViewCotroller: FollowingViewController) {
        let presenter = FollowingPresenterImplementation(view: followingViewCotroller)
        followingViewCotroller.presenter = presenter
    }
}
