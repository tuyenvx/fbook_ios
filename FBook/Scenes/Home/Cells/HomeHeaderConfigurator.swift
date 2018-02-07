//
//  HomeHeaderConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol HomeHeaderConfigurator {
    func configure(view: HomeHeader)
}

struct HomeHeaderConfiguratorImplementation {

    fileprivate weak var delegate: HomeHeaderViewDelegate?
    fileprivate let section: Int

    init(delegate: HomeHeaderViewDelegate?, section: Int) {
        self.delegate = delegate
        self.section = section
    }

}
extension HomeHeaderConfiguratorImplementation: HomeHeaderConfigurator {
    func configure(view: HomeHeader) {
        let presenter = HomeHeaderPresenterImplementation(view: view, delegate: delegate, section: section)
        view.presenter = presenter
    }
}
