//
//  SectionBookPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/13/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

protocol SectionBookView: class {
    weak var collectionView: UICollectionView! { get }
    func showLoadBooksError(_ message: String)
}

protocol SectionBookPresenter: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
}

class SectionBookPresenterImplementation: NSObject {

    fileprivate let router: SectionBookRouter?
    fileprivate weak var view: SectionBookView?
    fileprivate let sectionBook: SectionBook
    fileprivate var listItems = ListItems<Book>()
    fileprivate var isLoading = false
    fileprivate var isRefreshing = false
    fileprivate var refreshControl = UIRefreshControl()

    init(router: SectionBookRouter?, view: SectionBookView?, sectionBook: SectionBook) {
        self.router = router
        self.view = view
        self.sectionBook = sectionBook
        super.init()
        configureCollectionView()
        getListBook()
    }

    fileprivate func configureCollectionView() {
        view?.collectionView.backgroundView = refreshControl
        view?.collectionView.registerNibCell(type: BookCollectionViewCell.self)
        view?.collectionView.delegate = self
        view?.collectionView.dataSource = self
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }

    func refreshing() {
        if !isLoading {
            isRefreshing = true
            getListBook()
        }
    }

    fileprivate func getListBook(page: Int = 1) {
        weak var weakSelf = self
        isLoading = true
        BookProvider.getBooks(inSection: sectionBook, page: page, officeId: Office.currentId).on(failed: { error in
            weakSelf?.view?.showLoadBooksError(error.message)
        }, completed: {
        }, disposed: {
            weakSelf?.isLoading = false
            weakSelf?.isRefreshing = false
            weakSelf?.refreshControl.endRefreshing()
        }, value: { listItems in
            if weakSelf?.isRefreshing == false {
                weakSelf?.listItems.append(listItems)
            } else {
                weakSelf?.listItems = listItems
            }
            weakSelf?.view?.collectionView.reloadData()
        }).start()
    }
}

extension SectionBookPresenterImplementation: SectionBookPresenter {
}

extension SectionBookPresenterImplementation: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return BookCollectionViewCell.fitSizeItem(withSize: collectionView.frame.size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.showBookDetail(book: listItems.data[indexPath.row])
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == listItems.total - 1, isLoading == false, isRefreshing == false,
                let nextPage = listItems.nextPage {
            getListBook(page: nextPage)
        }
    }

}

extension SectionBookPresenterImplementation: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItems.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
                        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableNibCell(type: BookCollectionViewCell.self, atIndex: indexPath),
                let book = listItems.data[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.displayBook(book: book)
        return cell
    }

}
