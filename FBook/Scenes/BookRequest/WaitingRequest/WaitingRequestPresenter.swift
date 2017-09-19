//
//  WaitingRequestPresenter.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol WaitingRequestView: class {

    var tableView: UITableView! { get }
    func hideNoDataView(_ hide: Bool)
}

protocol WaitingRequestPresenter: UITableViewDataSource, UITableViewDelegate {

    var view: WaitingRequestView! { get }
    func configureTableView()
    func fetchWaitingBook(_ page: Int)
    func showAllRequest(for selectedCell: UITableViewCell)
}

extension WaitingRequestPresenter {

    func configureTableView() {
        view.tableView.dataSource = self
        view.tableView.delegate = self
    }
}

class WaitingRequestPresenterImplementation: NSObject {

    weak var view: WaitingRequestView!
    fileprivate var router: WaitingRequestViewRouter
    fileprivate var listBooks = ListItems<Book>()
    fileprivate var refreshControl = UIRefreshControl()
    fileprivate var isLoading = false

    init(view: WaitingRequestView, router: WaitingRequestViewRouter) {
        self.view = view
        self.router = router
        super.init()
        refreshControl.addTarget(self, action: #selector(fetchWaitingBook(_:)), for: .valueChanged)
        view.tableView.backgroundView = refreshControl
    }
}

extension WaitingRequestPresenterImplementation: WaitingRequestPresenter {

    func fetchWaitingBook(_ page: Int = 1) {
        guard !isLoading else {
            return
        }
        isLoading = true
        BookProvider.getListWaitingApprovedBook(page: page).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: { [weak self] in
            self?.isLoading = false
            self?.refreshControl.endRefreshing()
        }, value: { [weak self] listBooks in
            if page == 1 {
                self?.listBooks = listBooks
            } else {
                self?.listBooks.append(listBooks)
            }
            if listBooks.data.count > 0 {
                self?.view.hideNoDataView(true)
            } else {
                self?.view.hideNoDataView(false)
            }
            self?.view.tableView.reloadData()
        }).start()
    }

    func showAllRequest(for selectedCell: UITableViewCell) {
        if let indexPath = view.tableView.indexPath(for: selectedCell),
                let book = listBooks.data[safe: indexPath.row] {
            router.showAllRequest(for: book)
        }
    }
}

extension WaitingRequestPresenterImplementation: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBooks.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "BookWaitingCell", for: indexPath)
                as? BookWaitingCell, let book = listBooks.data[safe: indexPath.row] {
            cell.presenter = self
            cell.configure(book)
            return cell
        }
        return UITableViewCell()
    }
}

extension WaitingRequestPresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listBooks.data.count - 1, let nextPage = listBooks.nextPage {
            fetchWaitingBook(nextPage)
        }
    }
}
