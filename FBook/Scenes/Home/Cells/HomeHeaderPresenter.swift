//
//  HomeHeaderPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation


protocol HomeHeaderView: class {
    func displayConfigurator(_ configurator: HomeHeaderConfigurator)
    func displayTitle(_ title: String)
    func sholdShowMoreButton(_ isHidden: Bool)
}





protocol HomeHeaderPresenter {
    func didSelectSeeMore()
}

class HomeHeaderPresenterImplementation {

    fileprivate weak var view: HomeHeaderView?
    fileprivate weak var delegate: HomeHeaderViewDelegate?
    fileprivate let section: Int

    init(view: HomeHeaderView?, delegate: HomeHeaderViewDelegate?, section: Int) {
        self.view = view
        self.delegate = delegate
        self.section = section
    }
}

extension HomeHeaderPresenterImplementation: HomeHeaderPresenter {

    func didSelectSeeMore() {
        delegate?.didSelectSeeMore(atSection: section)
    }

}
