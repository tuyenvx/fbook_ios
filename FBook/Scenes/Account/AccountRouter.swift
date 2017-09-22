//
//  AccountRouter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol AccountRouter {
    func showUserDetail(for user: User)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)
}

class AccountRouterImplementation: AccountRouter {
    fileprivate weak var accountViewController: AccountViewController?
    fileprivate var user = User()

    init(accountViewController: AccountViewController) {
        self.accountViewController = accountViewController
    }

    func showUserDetail(for user: User) {
        self.user = user
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileViewController = segue.destination as? ProfileViewController {
            profileViewController.configurator =
                ProfileConfiguratorImplementation(user: user, viewController: profileViewController)
        }
    }
}
