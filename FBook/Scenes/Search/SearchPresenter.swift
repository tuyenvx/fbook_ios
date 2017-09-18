//
//  SearchPresenter.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import RxSwift
import ReactiveSwift

// MARK: - Enums

enum SearchType: Int {

    case title = 0
    case author
    case description

    func toString() -> String {
        switch self {
        case .title:
            return "Title"
        case .author:
            return "Author"
        case .description:
            return "Description"
        }
    }
}

enum SearchStore: Int {

    case `internal` = 0
    case google
}

// MARK: - Views

protocol SearchView: class {

    var searchBar: UISearchBar! { get }
    var tableView: UITableView! { get }
    func hideNoResultView(_ show: Bool)
}

protocol SearchBookCellView {

    func display(book: Book?)
}

// MARK: - Presenter

protocol SearchPresenter: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var view: SearchView! { get }
    func configureSearchBar()
    func configureTableView()
    func configureObserver()
    func change(searchType rawValue: Int)
    func change(store rawValue: Int)
    func dismissKeyboard()
}

extension SearchPresenter {

    func configureTableView() {
        view.tableView.delegate = self
        view.tableView.dataSource = self
    }

    func configureSearchBar() {
        view.searchBar.delegate = self
    }
}

class SearchPresenterImplementation: NSObject, SearchPresenter {

    weak var view: SearchView!
    fileprivate var listBooks = ListItems<Book>()
    fileprivate var store: SearchStore = .internal
    fileprivate var router: SearchViewRouter
    fileprivate var searchParams = SearchBookParams()
    fileprivate var searchText = Variable<String>("")
    fileprivate var bag = DisposeBag()
    fileprivate var request: ReactiveSwift.Disposable?

    init(view: SearchView, router: SearchViewRouter) {
        self.view = view
        self.router = router
        super.init()
    }

    func configureObserver() {
        self.searchText.asObservable().throttle(1.0, scheduler: MainScheduler.instance)
                .subscribe(onNext: { [weak self] _ in
            self?.search()
        }).addDisposableTo(bag)
    }

    func change(searchType rawValue: Int) {
        if let type = SearchType(rawValue: rawValue), searchParams.type != type {
            searchParams.type = type
            search()
        }
    }

    func change(store rawValue: Int) {
        if let store = SearchStore(rawValue: rawValue), self.store != store {
            self.store = store
        }
    }

    func search(_ page: Int = 1) {
        searchParams.keyword = searchText.value
        guard searchText.value != "" else {
            listBooks = ListItems<Book>()
            view.tableView.reloadData()
            return
        }
        request?.dispose()
        request = BookProvider.searchBook(officeId: Office.currentId, page: page, params: searchParams)
                .on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, value: { [weak self] (listBooks) in
            if page == 1 {
                self?.listBooks = listBooks
            } else {
                self?.listBooks.append(listBooks)
            }
            if let count = self?.listBooks.data.count, count > 0 {
                self?.view.hideNoResultView(true)
            } else {
                self?.view.hideNoResultView(false)
            }
            self?.view.tableView.reloadData()
        }).start()
    }

    func dismissKeyboard() {
        if view.searchBar.isFirstResponder {
            view.searchBar.resignFirstResponder()
        }
    }

}

extension SearchPresenterImplementation: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listBooks.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBookCell", for: indexPath) as?
                SearchBookCell else {
            return UITableViewCell()
        }
        let row = indexPath.row
        if row >= 0 && row < listBooks.data.count {
            let book = listBooks.data[row]
            cell.display(book: book)
        } else {
            cell.display(book: nil)
        }
        return cell
    }
}

extension SearchPresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        if row >= 0 && row < listBooks.data.count {
            let book = listBooks.data[row]
            router.showDetail(book: book)
        }
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == listBooks.data.count - 1, let nextPage = listBooks.nextPage {
            search(nextPage)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        dismissKeyboard()
    }
}

extension SearchPresenterImplementation: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchText.value = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.searchBar.resignFirstResponder()
    }
}
