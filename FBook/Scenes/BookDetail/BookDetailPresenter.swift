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

}

class BookDetailPresenterImplementation: NSObject {

    enum Section: Int {

        case basic
        case detail

        static var count: Int {
            return Section.detail.rawValue + 1
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

}

extension BookDetailPresenterImplementation: BookDetailPresenter {

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: BasicDetailTableViewCell.self)
        tableView.registerNibCell(type: UserReviewTableViewCell.self)
        tableView.registerNibHeaderFooter(type: BookDetailHeaderView.self)
        tableView.delegate = self
        tableView.dataSource = self
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
            weakSelf?.book.appendDetail(from: book)
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
        case Section.detail.rawValue: return book.detail?.reviews?.count ?? 0
        default: return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case Section.basic.rawValue:
            guard let cell = tableView.dequeueReusableNibCell(type: BasicDetailTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.updateUI(book: book)
            return cell
        case Section.detail.rawValue:
            guard let cell = tableView.dequeueReusableNibCell(type: UserReviewTableViewCell.self),
                  let review = book.detail?.reviews?[safe: indexPath.row] else {
                return UITableViewCell()
            }
            cell.updateUI(review: review)
            return cell
        default: return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case Section.detail.rawValue:
            let headerView = tableView.dequeueReusableHeaderFooter(type: BookDetailHeaderView.self)
            headerView?.contentView.backgroundColor = .white
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
        default: return 0.0
        }
    }

}
