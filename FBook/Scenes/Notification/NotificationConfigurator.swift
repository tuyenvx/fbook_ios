//
//  NotificationConfigurator.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol NotificationConfigurator {
    func configure(viewController: NotificationViewController)
}

class NotificationConfiguratorImplementation: NotificationConfigurator {
    func configure(viewController: NotificationViewController) {
        let presenter = NotificationPresenterImplementation(view: viewController)
        viewController.presenter = presenter
    }
}
