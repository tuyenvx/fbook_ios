//
//  BookActivitiesViewController.swift
//  FBook
//
//  Created by TuyenVX on 2/8/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class BookActivitiesViewController: GLViewPagerViewController {

    var presenter: BookActivitiesPresenter?
    var configurator: BookActivitiesConfigurator?

    var width: CGFloat {
        return self.view.frame.width
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDataSource(newDataSource: self)
        self.setDelegate(newDelegate: self)
        self.tabHeight = 40
        self.padding = 15
        self.leadingPadding = 15
        self.trailingPadding = 15
        self.tabAnimationType = GLTabAnimationType.GLTabAnimationType_WhileScrolling
        self.indicatorColor = .mainColor
        self.supportArabic = false
        self.fixTabWidth = false
        self.fixIndicatorWidth = false
        self.indicatorWidth = 20.0
    }

    func config(_ configurator: BookActivitiesConfigurator) {
        self.configurator = configurator
    }
}

extension BookActivitiesViewController: GLViewPagerViewControllerDataSource {
    func numberOfTabsForViewPager(_ viewPager: GLViewPagerViewController) -> Int {
        return presenter?.numberOfTab() ?? 0
    }

    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        return presenter?.viewForTabAtIndex(index) ?? UIView()
    }

    func contentViewControllerForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIViewController {
        return presenter?.getViewControllers()[index] ?? UIViewController()
    }
}

extension BookActivitiesViewController: GLViewPagerViewControllerDelegate {
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        presenter?.didChangeTabToIndex(viewPager, index, fromTabIndex)
    }

    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int, progress: CGFloat) {
        presenter?.willChangeTabToIndex(viewPager, index, fromTabIndex, progress)
    }

    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
        return presenter?.widthForTabIndex(index) ?? 138
    }
}

extension BookActivitiesViewController: BookActivitiesView {

}
