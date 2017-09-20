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

    init(view: BookRequestsView, router: BookRequestsViewRouter, book: Book) {
        self.view = view
        self.router = router
        self.book = book
    }
}

extension BookRequestsPresenterImplementation: BookRequestsPresenter {

    func loadBook() {
        view.display(book: book)
    }

    func changeRequestType(_ type: BookRequestType) {
        // TODO: Implement when user change request type here
    }
}

extension BookRequestsPresenterImplementation: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // TODO: Need change when integrate API
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableNibCell(type: BookRequestCell.self) {
            // TODO: Configure cell here
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
