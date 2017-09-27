//
//  SortBookRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol SortBookRouter {
    func dismiss()
}

struct SortBookRouterImplementation {

    fileprivate var viewController: SortBookViewController?
    init(viewController: SortBookViewController?) {
        self.viewController = viewController
    }
}

extension SortBookRouterImplementation: SortBookRouter {

    func dismiss() {
        viewController?.dismiss(animated: false, completion: nil)
    }

}
