//
//  CategoryPickerRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol CategoryPickerRouter {
    func dismiss()
}

struct CategoryPickerRouterImplementation {

    fileprivate var viewController: CategoryPickerViewController?
    init(viewController: CategoryPickerViewController?) {
        self.viewController = viewController
    }
}

extension CategoryPickerRouterImplementation: CategoryPickerRouter {

    func dismiss() {
        viewController?.dismiss(animated: false, completion: nil)
    }

}
