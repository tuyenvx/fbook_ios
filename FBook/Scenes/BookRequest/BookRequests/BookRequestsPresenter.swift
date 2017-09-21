//
//  BookRequestsPresenter.swift
//  FBook
//
//  Created by Huy Pham on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

enum BookRequestType: Int {
    case waitingAndReading = 0
    case returningAndReturned
}

protocol BookRequestsView: class {

    var tableView: UITableView! { get }
    func display(book: Book)
}

protocol BookRequestsPresenter: UITableViewDataSource, UITableViewDelegate {

    var view: BookRequestsView! { get }
    func loadBook()
    func configureTableView()
    func changeRequestType(_ type: BookRequestType)
    func approve(_ request: BookRequest)
}

extension BookRequestsPresenter {

    func configureTableView() {
        view.tableView.delegate = self
        view.tableView.dataSource = self
        view.tableView.registerNibHeaderFooter(type: BookRequestsTypeHeader.self)
    }
}

class BookRequestsPresenterImplementation: NSObject {

    weak var view: BookRequestsView!
    fileprivate var book: Book
    fileprivate var router: BookRequestsViewRouter
    fileprivate var requestUsers: [BookRequest] = []
    fileprivate var currentType: BookRequestType = .waitingAndReading

    init(view: BookRequestsView, router: BookRequestsViewRouter, book: Book) {
        self.view = view
        self.router = router
        self.book = book
        super.init()
        fetchBook()
    }

    func fetchBook() {
        AlertHelper.showLoading()
        BookProvider.getBookApprovedDetail(bookId: book.id).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            AlertHelper.hideLoading()
        }, value: { [weak self] book in
            if let weakSelf = self {
                weakSelf.book = book
                weakSelf.fetchRequest(with: weakSelf.currentType)
            }
        }).start()
    }

    func fetchRequest(with type: BookRequestType) {
        switch type {
        case .waitingAndReading:
            requestUsers = book.requests?.waiting ?? []
            requestUsers.append(contentsOf: book.requests?.reading ?? [])
        case .returningAndReturned:
            requestUsers = book.requests?.returning ?? []
            requestUsers.append(contentsOf: book.requests?.returned ?? [])
        }
        view.tableView.reloadData()
    }
}

extension BookRequestsPresenterImplementation: BookRequestsPresenter {

    func loadBook() {
        view.display(book: book)
    }

    func changeRequestType(_ type: BookRequestType) {
        currentType = type
        fetchRequest(with: type)
    }

    func approve(_ request: BookRequest) {
        var params = ApproveBookParams()
        guard let status = BookingStatus(rawValue: request.pivot?.status ?? 0),
                let bookId = request.pivot?.bookId else {
            return
        }
        if status == .reading {
            params.key = .unapprove
        }
        params.userId = request.pivot?.userId
        AlertHelper.showLoading()
        BookProvider.approveBook(bookId: bookId, params: params).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            AlertHelper.hideLoading()
        }, value: { [weak self] success in
            if success {
                self?.fetchBook()
            } else {
                AlertHelper.hideLoading()
            }
        }).start()
    }
}

extension BookRequestsPresenterImplementation: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestUsers.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableNibCell(type: BookRequestCell.self),
                let request = requestUsers[safe: indexPath.row] {
            cell.display(request: request)
            cell.presenter = self
            return cell
        }
        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header = tableView.dequeueReusableHeaderFooter(type: BookRequestsTypeHeader.self) {
            header.presenter = self
            return header
        }
        return nil
    }
}
