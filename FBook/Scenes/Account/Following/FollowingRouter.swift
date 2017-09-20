//
//  FollowingRouter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol FollowingRouter {

    func showFollowingUserInfo(_ user: User)

}

class FollowingRouterImplementation: FollowingRouter {

    fileprivate weak var view: FollowingViewController?
    fileprivate var user: User!

    init(view: FollowingViewController) {
        self.view = view
    }

    func showFollowingUserInfo(_ user: User) {
        guard let accountViewController = UIStoryboard.account.instantiateInitialViewController()
            as? AccountViewController else {return}
        accountViewController.configurator = AccountConfiguratorImplementation()
        accountViewController.configurator?.configure(accountViewController: accountViewController, user: user)
        view?.navigationController?.pushViewController(accountViewController, animated: true)
    }
}
