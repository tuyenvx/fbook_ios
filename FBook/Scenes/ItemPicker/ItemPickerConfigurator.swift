//
//  ItemPickerConfigurator.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ItemPickerConfigurator {

    func configure(viewController: ItemPickerViewController)

}

class ItemPickerConfiguratorImpl: ItemPickerConfigurator {

    let items: [String]

    init(items: [String]) {
        self.items = items
    }

    func configure(viewController: ItemPickerViewController) {
        let router = ItemPickerViewRouterImpl(viewController: viewController)
        let presenter = ItemPickerPresenterImpl(view: viewController, router: router, items: items)
        viewController.presenter = presenter
    }

}
