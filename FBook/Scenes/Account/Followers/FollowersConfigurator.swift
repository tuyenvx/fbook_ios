//
//  FollowersConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol FollowersConfigurator {
    func configure(followersViewCotroller: FollowersViewController)
}

class FollowersConfiguratorImplementation: FollowersConfigurator {
    func configure(followersViewCotroller: FollowersViewController) {
        let presenter = FollowersPresenterImplementation(view: followersViewCotroller)
        followersViewCotroller.presenter = presenter
    }
}
