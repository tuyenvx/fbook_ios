//
//  BaseViewConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol BaseViewConfigurator {
    func configure(view: BaseViewController) -> BasePresenter?
}

struct BaseViewConfiguratorImplementation {
}

extension BaseViewConfiguratorImplementation: BaseViewConfigurator {

    func configure(view: BaseViewController) -> BasePresenter? {
        let router = BaseViewRouterImplementation(view: view)
        let presenter = BasePresenterImplementation(view: view, router: router)
        return presenter
    }

}
