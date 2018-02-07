//
//  PersonalConfigurator.swift
//  FBook
//
//  Created by ThietTB on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation

protocol PersonalConfigurator {
    func configure(viewController: PersonalViewController)
}

class PersonalConfiguratorImplementation: PersonalConfigurator{
    fileprivate var user: User
    
    init(user: User) {
        self.user = user
    }
    
    func configure(viewController: PersonalViewController) {
        let router = PersonalRouterImplementation(viewController: viewController)
        let presenter = PersonalPresenterImplementation(view: viewController, router: router, user: user)
        viewController.presenter = presenter
    }
}
