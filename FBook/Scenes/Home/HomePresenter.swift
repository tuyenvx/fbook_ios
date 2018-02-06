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
    func searchButtonTapped()
    func loginButtonTapped()
    func getListSectionBook()
    func configure(tableView: UITableView)
    func didChoseOffice()
    func menuButtonTapped(senderFrame: CGRect)
}

class HomePresenterImplementation: NSObject {

    fileprivate weak var view: HomeView?
    fileprivate var router: HomeViewRouter?
    fileprivate var sectionBooks: [SectionBook] = []
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var isLoading = false
    fileprivate let distanceBetweenCell: CGFloat = 10

    init(view: HomeView?, router: HomeViewRouter?) {
        self.view = view
        self.router = router
        super.init()
        AlertHelper.showLoading()
        getListSectionBook()
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
        let books = sectionBooks[section].books ?? []
        header.sholdShowMoreButton(books.count == 0)
        header.displayConfigurator(configurator)
        header.displayTitle(sectionBooks[section].title)
    }

    fileprivate func getBooks(_ index: Int) -> [Book] {
        return sectionBooks[index].books ?? []
    }
}

extension HomePresenterImplementation: HomePresenter {

    func searchButtonTapped() {
        router?.showSearchScreen()
    }

    func loginButtonTapped() {
        router?.showLoginScreen()
    }

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: HomeTableViewCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundView = refreshControl
        refreshControl.addTarget(self, action: #selector(getListSectionBook), for: .valueChanged)
    }

    @objc func getListSectionBook() {
        if isLoading {
            return
        }
        isLoading = true
        weak var weakSelf = self
        HomeProvider.getListSectionBook().on(failed: { error in
            weakSelf?.handleLoadBookError(error)
        }, completed: {
        }, disposed: {
            AlertHelper.hideLoading()
            weakSelf?.refreshControl.endRefreshing()
            weakSelf?.isLoading = false
        }, value: { sectionBooks in
            weakSelf?.handleLoadBookSuccess(sectionBooks)
        }).start()
    }

    func didChoseOffice() {
        getListSectionBook()
    }

    func menuButtonTapped(senderFrame: CGRect) {
        router?.showMenuSetting(delegate: self, senderFrame: senderFrame)
    }

}

extension HomePresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let books = sectionBooks[indexPath.section].books ?? []
        if books.count == 0 {
            return distanceBetweenCell
        }
        let sizeTable = tableView.frame.size
        let cellBookSize = BookCollectionViewCell.fitSizeItem(withSize: CGSize(width: sizeTable.width - 40,
            height: sizeTable.height))
        return cellBookSize.height + 20
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

extension HomePresenterImplementation: MenuSettingPresenterDelegate {

    func didSelectFeedback() {
        router?.showFeedback()
    }

    func didSelectMoreTools() {
        router?.showMoreTools()
    }

    func didSelectWorkspace() {
        router?.showWorkspace()
    }

}
