//
//  SectionBookConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol SectionBookConfigurator {
    func configure(view: SectionBookViewController)
}

struct SectionBookConfiguratorImplementation {

    fileprivate let sectionBook: SectionBook
    init(sectionBook: SectionBook) {
        self.sectionBook = sectionBook
    }

}

extension SectionBookConfiguratorImplementation: SectionBookConfigurator {

    func configure(view: SectionBookViewController) {
        let router = SectionBookRouterImplementation(viewController: view)
        let presenter = SectionBookPresenterImplementation(router: router, view: view, sectionBook: sectionBook)
        view.presenter = presenter
    }

}
