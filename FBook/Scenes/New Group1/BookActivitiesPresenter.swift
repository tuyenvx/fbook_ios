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

}
