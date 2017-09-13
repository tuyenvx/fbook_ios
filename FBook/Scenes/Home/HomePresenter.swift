//
//  HomePresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

protocol HomeView: class {
    func refreshBooks()
    func showLoadBooksError(message: String)
}

protocol HomePresenter {
    func getListSectionBook()
    func configure(tableView: UITableView)
}

class HomePresenterImplementation: NSObject {

    fileprivate weak var view: HomeView?
    fileprivate var router: HomeViewRouter?
    fileprivate var sectionBooks: [SectionBook] = []

    init(view: HomeView?, router: HomeViewRouter?) {
        self.view = view
        self.router = router
    }

    fileprivate func handleLoadBookSuccess(_ sectionBooks: [SectionBook]) {
        self.sectionBooks.removeAll()
        self.sectionBooks.append(contentsOf: sectionBooks)
        view?.refreshBooks()
    }

    fileprivate func handleLoadBookError(_ error: Error) {
        view?.showLoadBooksError(message: error.message)
    }

    fileprivate func configure(cell: HomeCellView, indexPath: IndexPath) {
        let books = sectionBooks[indexPath.section].books ?? []
        let config = HomeCellConfiguratorImplementation(books: books, delegate: self)
        cell.displayConfigurator(config)
    }

    fileprivate func configure(header: HomeHeaderView, section: Int) {
        let configurator = HomeHeaderConfiguratorImplementation(delegate: self, section: section)
        header.displayConfigurator(configurator)
        header.displayTitle(sectionBooks[section].title)
    }
}

extension HomePresenterImplementation: HomePresenter {

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: HomeTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getListSectionBook() {
        AlertHelper.showLoading()
        weak var weakSelf = self
        HomeProvider.getListSectionBook().on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.handleLoadBookError(error)
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { sectionBooks in
            weakSelf?.handleLoadBookSuccess(sectionBooks)
        }).start()
    }

}

extension HomePresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = HomeHeader()
        configure(header: header, section: section)
        return header
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
}

extension HomePresenterImplementation: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionBooks.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableNibCell(type: HomeTableViewCell.self) ?? HomeTableViewCell()
        configure(cell: cell, indexPath: indexPath)
        return cell
    }

}

extension HomePresenterImplementation: HomeCellPresenterDelegate {
    func didSelectBook(_ book: Book) {
        router?.showDetailBook(book)
    }
}

extension HomePresenterImplementation: HomeHeaderViewDelegate {
    func didSelectSeeMore(atSection section: Int) {
        router?.showSeeMoreSectionBook(sectionBooks[section])
    }
}
