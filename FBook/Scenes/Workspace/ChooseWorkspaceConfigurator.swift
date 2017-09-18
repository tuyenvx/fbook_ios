//
//  ChooseWorkspaceConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ChooseWorkspaceConfigurator {
    func configure(view: ChooseWorkspaceViewController)
}

struct ChooseWorkspaceConfiguratorImplementation {

    fileprivate weak var delegate: ChooseWorkspacePresenterDelegate?

    init(delegate: ChooseWorkspacePresenterDelegate? = nil) {
        self.delegate = delegate
    }

}

extension ChooseWorkspaceConfiguratorImplementation: ChooseWorkspaceConfigurator {

    func configure(view: ChooseWorkspaceViewController) {
        let router = ChooseWorkspaceRouterImplementation(viewController: view)
        let presenter = ChooseWorkspacePresenterImplementation(view: view, router: router, delegate: delegate)
        view.presenter = presenter
    }

}
