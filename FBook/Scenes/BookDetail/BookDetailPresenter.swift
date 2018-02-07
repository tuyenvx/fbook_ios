//
//  BookDetailPresenter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/12/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol BookDetailView: class {

    func showHideView(_ needToShow: Bool)
    func updateUI()

}

protocol BookDetailPresenter {

    func fetchBookDetail()
    func configure(tableView: UITableView)
    func prepare(for segue: UIStoryboardSegue, sender: Any?)

}

class BookDetailPresenterImplementation: NSObject {

    enum Section: Int {

        case basic
        case owner

        static var count: Int {
            return Section.owner.rawValue + 1
        }

    }

    private(set) var router: BookDetailViewRouter?
    fileprivate weak var view: BookDetailView?

    fileprivate var book: Book

    init(view: BookDetailView, router: BookDetailViewRouter, book: Book) {
        self.view = view
        self.router = router
        self.book = book
    }

    fileprivate func cellForEmptyRow(in tableView: UITableView, message: String) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: EmptyTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.updateUI(message: message)
        return cell
    }

    fileprivate func cellForBasicDetail(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: BasicDetailTableViewCell.self) else {
            return UITableViewCell()
        }
        cell.updateUI(book: book)
        cell.delegate = self
        return cell
    }

    fileprivate func cellForShareBy(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableNibCell(type: ShareByTableViewCell.self) else {
            return UITableViewCell()
        }
        let owners = book.requests?.owners ?? []
        let configutor = ShareByTableViewCellConfiguratorImplement.init(owners: owners, delegate: self)
        cell.displayConfigurator(configutor)
        return cell
    }
}

extension BookDetailPresenterImplementation: BookDetailPresenter {

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: BasicDetailTableViewCell.self)
        tableView.registerNibCell(type: ShareByTableViewCell.self)
        tableView.registerNibCell(type: EmptyTableViewCell.self)
        tableView.registerNibHeaderFooter(type: BookDetailHeaderView.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? BaseNavigationController,
           let ratingViewController = navigationController.viewControllers.first as? RatingViewController {
            ratingViewController.configurator = RatingConfiguratorImplementation(bookId: 2)
        }
    }

    func fetchBookDetail() {
        AlertHelper.showLoading()
        weak var weakSelf = self
        BookProvider.getBookDetail(bookId: book.id).on(starting: {
            weakSelf?.view?.showHideView(false)
        }, failed: { _ in
            AlertHelper.hideLoading()
            // TODO: Handle error when fetch book detail failed
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { book in
            weakSelf?.view?.showHideView(true)
            weakSelf?.book = book
            weakSelf?.view?.updateUI()
        }).start()
    }

}

extension BookDetailPresenterImplementation: ShareByTableViewCellDelegate {

    func didSelectedOwner(_ owner: BookRequest) {
        
    }
}

extension BookDetailPresenterImplementation: BasicDetailTableViewCellDelegate {

    func didSelectedActivities(_ activites: Int) {
        router?.showBookActivitiesViewController(listRequest: Book.ListRequests.init(), index: activites)
    }
}

extension BookDetailPresenterImplementation: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.basic.rawValue: return 1
        case Section.owner.rawValue: return 1
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.basic.rawValue:
            return cellForBasicDetail(in: tableView, at: indexPath)
        case Section.owner.rawValue:
            return cellForShareBy(in: tableView, at: indexPath)
        default: return UITableViewCell()
        }
    }
}

extension BookDetailPresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case Section.basic.rawValue:
            return UITableViewAutomaticDimension
        case Section.owner.rawValue:
            return 130
        default:
            return 0
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kZeroFloat
    }

}
