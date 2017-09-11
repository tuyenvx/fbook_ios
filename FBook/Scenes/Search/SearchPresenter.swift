//
//  SearchPresenter.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

enum SearchType: Int {

    case title = 100
    case author
    case description
}

enum SearchStore: Int {

    case `internal` = 0
    case google
}

protocol SearchView: class {

    func updateSearchType(_ type: SearchType)
}

protocol SearchPresenter: class {

    var numberOfBooks: Int { get }
    var router: SearchViewRouter { get }
    func configure(cell: SearchBookCellView, forRow row: Int)
    func select(row: Int)
    func change(searchType rawValue: Int)
    func change(store rawValue: Int)
    func change(searchText text: String)
    func search()
}

protocol SearchBookCellView {

    func display(book: Book?)
}

class SearchPresenterImplementation: SearchPresenter {

    fileprivate weak var view: SearchView?
    fileprivate var books: [Book] = []
    fileprivate var searchType: SearchType = .title
    fileprivate var store: SearchStore = .internal
    fileprivate var searchText: String = ""
    var router: SearchViewRouter
    var numberOfBooks: Int {
        return books.count
    }

    init(view: SearchView, router: SearchViewRouter) {
        self.view = view
        self.router = router
    }

    func configure(cell: SearchBookCellView, forRow row: Int) {
        if row >= 0 && row < books.count {
            let book = books[row]
            cell.display(book: book)
        } else {
            cell.display(book: nil)
        }
    }

    func select(row: Int) {
        // TODO: Implementation when select cell
    }

    func change(searchType rawValue: Int) {
        if let type = SearchType(rawValue: rawValue), searchType != type {
            searchType = type
            view?.updateSearchType(type)
        }
    }

    func change(store rawValue: Int) {
        if let store = SearchStore(rawValue: rawValue), self.store != store {
            self.store = store
        }
    }

    func change(searchText text: String) {
        searchText = text
    }

    func search() {
        // TODO: Code to search here
    }
}
