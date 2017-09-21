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
        case detail

        static var count: Int {
            return Section.detail.rawValue + 1
        }

    }

    enum DetailType: Int {

        case reviews
        case readingUsers
        case waitingUsers

    }

    private(set) var router: BookDetailViewRouter?
    fileprivate weak var view: BookDetailView?

    fileprivate var book: Book
    fileprivate var currentDetailType = DetailType.reviews

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
        return cell
    }

    fileprivate func cellForMoreDetail(in tableView: UITableView, at indexPath: IndexPath) -> UITableViewCell {
        switch currentDetailType {
        case .reviews:
            if indexPath.row == 0 {
                guard let cell = tableView.dequeueReusableNibCell(type: WriteReviewTableViewCell.self) else {
                    return UITableViewCell()
                }
                cell.writeReviewButtonTapped = { [weak self] in
                    self?.writeReviewButtonTapped()
                }
                return cell
            }
            guard let cell = tableView.dequeueReusableNibCell(type: UserReviewTableViewCell.self),
                  let review = book.detail?.reviews?[safe: indexPath.row - 1] else {
                return cellForEmptyRow(in: tableView, message: "No reviews.")
            }
            cell.updateUI(review: review)
            return cell
        case .readingUsers:
            guard let cell = tableView.dequeueReusableNibCell(type: UserTableViewCell.self),
                  let user = book.requests?.reading?[safe: indexPath.row] else {
                return cellForEmptyRow(in: tableView, message: "No users.")
            }
            cell.updateUI(user: user, status: "reading")
            return cell
        case .waitingUsers:
            guard let cell = tableView.dequeueReusableNibCell(type: UserTableViewCell.self),
                  let user = book.requests?.waiting?[safe: indexPath.row] else {
                return cellForEmptyRow(in: tableView, message: "No users.")
            }
            cell.updateUI(user: user, status: "waiting")
            return cell
        }
    }

    fileprivate func writeReviewButtonTapped() {
        if User.currentUser == nil {
            router?.presentLoginViewController()
        } else {
            router?.presentRatingViewController()
        }
    }

}

extension BookDetailPresenterImplementation: BookDetailPresenter {

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: BasicDetailTableViewCell.self)
        tableView.registerNibCell(type: UserReviewTableViewCell.self)
        tableView.registerNibCell(type: UserTableViewCell.self)
        tableView.registerNibCell(type: EmptyTableViewCell.self)
        tableView.registerNibCell(type: WriteReviewTableViewCell.self)
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

extension BookDetailPresenterImplementation: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case Section.basic.rawValue: return 1
        case Section.detail.rawValue:
            switch currentDetailType {
            case .reviews:
                let reviewsCount = book.detail?.reviews?.count ?? 0
                return reviewsCount == 0 ? 2 : reviewsCount + 1
            case .readingUsers:
                let readingCount = book.requests?.reading?.count ?? 0
                return readingCount == 0 ? 1 : readingCount
            case .waitingUsers:
                let waitingCount = book.requests?.waiting?.count ?? 0
                return waitingCount == 0 ? 1 : waitingCount
            }
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.basic.rawValue:
            return cellForBasicDetail(in: tableView, at: indexPath)
        case Section.detail.rawValue:
            return cellForMoreDetail(in: tableView, at: indexPath)
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Section.detail.rawValue:
            let headerView = tableView.dequeueReusableHeaderFooter(type: BookDetailHeaderView.self)
            headerView?.contentView.backgroundColor = .white
            headerView?.changeDetailType = { [weak self] selectedIndex in
                guard let detailType = DetailType(rawValue: selectedIndex) else {
                    return
                }
                self?.currentDetailType = detailType
                self?.view?.updateUI()
            }
            return headerView
        default: return nil
        }
    }

}

extension BookDetailPresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case Section.detail.rawValue: return 60.0
        default: return kZeroFloat
        }
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return kZeroFloat
    }

}
