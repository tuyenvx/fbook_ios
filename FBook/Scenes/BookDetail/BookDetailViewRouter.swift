//
//  BookDetailViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol BookDetailViewRouter {

    func presentRatingViewController()
    func presentLoginViewController()
    func showBookActivitiesViewController(listRequest: Book.ListRequests, index: Int)
}

class BookDetailViewRouterImplementation {

    fileprivate weak var viewController: BookDetailViewController?

    init(viewController: BookDetailViewController) {
        self.viewController = viewController
    }

    func getBookActivitiVC(listRequest: Book.ListRequests, index: Int) -> BookActivitiesViewController {
        let bookActivitiesStoryBoard = UIStoryboard.bookActivities
        guard let userReviewVC = UserReviewViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? UserReviewViewController,
            let userWaitingVC = UserWaitingViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? UserWaitingViewController,
            let userReadingVC = UserReadingViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? UserReadingViewController,
            let userReturningVC = UserReturningViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? UserReturningViewController,
            let userReturnedVC = UserReturnedViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? UserReturnedViewController,
            let bookActivitiesVC = BookActivitiesViewController.loadFromStoryBoard(bookActivitiesStoryBoard)
                as? BookActivitiesViewController else {
            return BookActivitiesViewController()
        }
        let viewControllers = [userReviewVC, userWaitingVC, userReadingVC, userReturningVC, userReturnedVC]
        let titles = ["User Review", "User Waiting", "User Reading", "User Returning", "User Returned"]
        let configurator = BookActivitiesConfiguratorImplement.init(viewControllers: viewControllers, currentIndex: 0, titles: titles, requests: listRequest)
        configurator.config(viewController: bookActivitiesVC)
        bookActivitiesVC.config(configurator)
        bookActivitiesVC.defaultDisplayPageIndex = index

        return bookActivitiesVC
    }

}

extension BookDetailViewRouterImplementation: BookDetailViewRouter {

    func showBookActivitiesViewController(listRequest: Book.ListRequests, index: Int) {
        let bookActivitiesVC = getBookActivitiVC(listRequest: listRequest, index: index)
        viewController?.navigationController?.pushViewController(bookActivitiesVC, animated: true)
    }

    func presentRatingViewController() {
        viewController?.performSegue(withIdentifier: "rating", sender: self)
    }

    func presentLoginViewController() {
        viewController?.performSegue(withIdentifier: "login", sender: self)
    }

}
