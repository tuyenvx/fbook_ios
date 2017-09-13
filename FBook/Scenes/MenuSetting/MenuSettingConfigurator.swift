//
//  MenuConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol MenuSettingConfigurator {
    func configure(_ view: MenuSettingViewController)
}

struct MenuConfiguratorImplementation {

    fileprivate weak var delegate: MenuSettingPresenterDelegate?
    fileprivate let senderFrame: CGRect

    init(delegate: MenuSettingPresenterDelegate?, senderFrame: CGRect) {
        self.delegate = delegate
        self.senderFrame = senderFrame
    }

}

extension MenuConfiguratorImplementation: MenuSettingConfigurator {

    func configure(_ view: MenuSettingViewController) {
        let router = MenuSettingRouterImplementation(viewController: view)
        let presenter = MenuSettingPresenterImplementation(view: view, senderFrame: senderFrame, delegate: delegate,
            router: router)
        view.presenter = presenter
    }

}
