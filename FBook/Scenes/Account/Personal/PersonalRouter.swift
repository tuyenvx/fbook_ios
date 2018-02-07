//
//  PersonalRouter.swift
//  FBook
//
//  Created by ThietTB on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol PersonalRouter {
    func showUserDetail(_ user: User)
}

class PersonalRouterImplementation: PersonalRouter {
    
    fileprivate weak var viewController: PersonalViewController?

    init(viewController: PersonalViewController) {
        self.viewController = viewController
    }
    func showUserDetail(_ user: User) {
    }
}
