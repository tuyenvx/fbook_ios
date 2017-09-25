//
//  AccountRouter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol AccountRouter {
}

class AccountRouterImplementation: AccountRouter {

    fileprivate weak var viewController: AccountViewController?

    init(viewController: AccountViewController) {
        self.viewController = viewController
    }
}
