//
//  BookActivitiesConfigurator.swift
//  FBook
//
//  Created by TuyenVX on 2/8/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol BookActivitiesConfigurator {
    func config(viewController: BookActivitiesViewController)
}

struct BookActivitiesConfiguratorImplement {
    fileprivate var viewControllers: [UIViewController]
    fileprivate var currentIndex: Int
    fileprivate var titles: [String]
    fileprivate var requests: Book.ListRequests

    init(viewControllers: [UIViewController], currentIndex: Int, titles: [String], requests: Book.ListRequests) {
        self.viewControllers = viewControllers
        self.currentIndex = currentIndex
        self.titles = titles
        self.requests = requests
    }
}

extension BookActivitiesConfiguratorImplement: BookActivitiesConfigurator {
    func config(viewController: BookActivitiesViewController) {
        let presenter = BookActivitiesPresenterImplement(view: viewController, viewControllers: viewControllers, currentIndex: currentIndex, titles: titles, requests: requests)
        viewController.presenter = presenter
    }
}
