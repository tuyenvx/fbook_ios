//
//  ChooseWorkspaceRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol ChooseWorkspaceRouter {
    func dismiss()
}

struct ChooseWorkspaceRouterImplementation {

    fileprivate weak var viewController: ChooseWorkspaceViewController?

    init(viewController: ChooseWorkspaceViewController?) {
        self.viewController = viewController
    }

}

extension ChooseWorkspaceRouterImplementation: ChooseWorkspaceRouter {

    func dismiss() {
        viewController?.dismiss(animated: false, completion: nil)
    }

}
