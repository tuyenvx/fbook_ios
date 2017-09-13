//
//  MenuSettingRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol MenuSettingRouter {
    func dismiss()
}

struct MenuSettingRouterImplementation {

    fileprivate weak var viewController: MenuSettingViewController?

    init(viewController: MenuSettingViewController?) {
        self.viewController = viewController
    }

}

extension MenuSettingRouterImplementation: MenuSettingRouter {

    func dismiss() {
        viewController?.dismiss(animated: false, completion: nil)
    }

}
