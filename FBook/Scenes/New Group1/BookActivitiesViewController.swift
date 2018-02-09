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
        return presenter?.getViewControllers().count ?? 0
    }

    func viewForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIView {
        let label: UILabel = UILabel.init()
        label.text = presenter?.getTitles()[index] ?? ""
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = NSTextAlignment.center
        label.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
        return label
    }

    func contentViewControllerForTabAtIndex(_ viewPager: GLViewPagerViewController, index: Int) -> UIViewController {
        return presenter?.getViewControllers()[index] ?? UIViewController()
    }
}

extension BookActivitiesViewController: GLViewPagerViewControllerDelegate {
    func didChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int) {
        guard let prevLabel: UILabel = viewPager.tabViewAtIndex(index: fromTabIndex) as? UILabel,
            let currentLabel: UILabel = viewPager.tabViewAtIndex(index: index) as? UILabel else {
                return
        }
        prevLabel.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        currentLabel.transform = CGAffineTransform.identity.scaledBy(x: 1.0, y: 1.0)
        prevLabel.textColor = UIColor.darkGray
        currentLabel.textColor = .mainColor
    }

    func willChangeTabToIndex(_ viewPager: GLViewPagerViewController, index: Int, fromTabIndex: Int, progress: CGFloat) {
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

    func widthForTabIndex(_ viewPager: GLViewPagerViewController, index: Int) -> CGFloat {
        let prototypeLabel: UILabel = UILabel.init()
        prototypeLabel.text = presenter?.getTitles()[index] ?? ""
        prototypeLabel.textAlignment = NSTextAlignment.center
        prototypeLabel.font = UIFont.systemFont(ofSize: 16.0)
        return prototypeLabel.intrinsicContentSize.width
    }
}

extension BookActivitiesViewController: BookActivitiesView {

}
