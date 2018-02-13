//
//  BookActivitiesPresenter.swift
//  FBook
//
//  Created by TuyenVX on 2/8/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol BookActivitiesView {

}

protocol BookActivitiesPresenter {
    func getViewControllers() -> [UIViewController]
    func getTitles() -> [String]
    func viewForTabAtIndex(_ index: Int) -> UIView
    func numberOfTab() -> Int
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, _ index: Int, _ fromTabIndex: Int)
    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, _ index: Int, _ fromTabIndex: Int, _ progress: CGFloat)
    func widthForTabIndex(_ index: Int) -> CGFloat
}

class BookActivitiesPresenterImplement {
    fileprivate var viewControllers: [UIViewController]
    fileprivate var titles: [String]
    fileprivate var currentIndex: Int = 0
    fileprivate var view: BookActivitiesView?
    fileprivate var totalPage: Int {
        return viewControllers.count
    }
    var requests: Book.ListRequests

    init(view: BookActivitiesView?, viewControllers: [UIViewController], currentIndex: Int, titles: [String], requests: Book.ListRequests) {
        self.view = view
        self.viewControllers = viewControllers
        self.currentIndex = currentIndex
        self.titles = titles
        self.requests = requests
    }

    func loadPage(page: Int) {
        guard page == -1 || page == totalPage else { return }
        currentIndex = page

    }
}

extension BookActivitiesPresenterImplement: BookActivitiesPresenter {

    func getTitles() -> [String] {
        return titles
    }

    func getViewControllers() -> [UIViewController] {
        return viewControllers
    }

    func viewForTabAtIndex(_ index: Int) -> UIView {
        let label: UILabel = UILabel.init()
        label.text = titles[index]
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        return label
    }

    func numberOfTab() -> Int {
        return viewControllers.count
    }

    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, _ index: Int, _ fromTabIndex: Int) {
        guard let prevLabel: UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as? UILabel,
            let currentLabel: UILabel = viewPager.tabViewAtIndex(index: index) as? UILabel else {
                return
        }
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        prevLabel.textColor = UIColor.darkGray
        currentLabel.textColor = .mainColor
    }

    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, _ index: Int, _ fromTabIndex: Int, _ progress: CGFloat) {
        if fromTabIndex == index {
            return
        }
        
        guard let prevLabel: UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as? UILabel,
            let currentLabel: UILabel = viewPager.tabViewAtIndex(index: index) as? UILabel else {
                return }
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0 - (0.1 * progress), y: 1.0 - (0.1 * progress))
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9 + (0.1 * progress), y: 0.9 + (0.1 * progress))
        currentLabel.textColor =  .mainColor
        prevLabel.textColor = UIColor.darkGray
    }

    func widthForTabIndex(_ index: Int) -> CGFloat {
        let prototypeLabel: UILabel = UILabel.init()
        prototypeLabel.text = titles[index]
        prototypeLabel.textAlignment = NSTextAlignment.center
        prototypeLabel.font = UIFont.systemFont(ofSize: 16.0)
        return prototypeLabel.intrinsicContentSize.width
    }
}
