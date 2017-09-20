//
//  CategoryPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol CategoryView: class {
    weak var collectionView: UICollectionView! { get }
    func displayLoading(isLoading: Bool)
}

protocol CategoryPresenter: class {
    func setCategory(_ category: Category?)
}

class CategoryPresenterImplementation: NSObject {

    fileprivate weak var view: CategoryView?
    fileprivate let router: CategoryRouter
    fileprivate var category: Category?
    fileprivate var listItem = ListItemsCategory()
    fileprivate let refreshControl = UIRefreshControl()
    fileprivate var isLoading = false

    init(view: CategoryView, router: CategoryRouter) {
        self.view = view
        self.router = router
        super.init()
        configure()
        self.view?.displayLoading(isLoading: true)
        getListBook()
    }

    fileprivate func configure() {
        view?.collectionView.registerNibCell(type: BookCollectionViewCell.self)
        view?.collectionView.delegate = self
        view?.collectionView.dataSource = self
        view?.collectionView.backgroundView = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshing), for: .valueChanged)
    }

    @objc func refreshing() {
        getListBook()
    }

    fileprivate func getListBook(page: Int = 1) {
        guard let categoryId = category?.id else {
            return
        }
        if isLoading {
            return
        }
        isLoading = true
        weak var weakSelf = self
        CategoryProvider.getBooks(inCategory: categoryId, page: page).on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            weakSelf?.view?.displayLoading(isLoading: false)
            weakSelf?.isLoading = false
            weakSelf?.refreshControl.endRefreshing()
        }, value: { itemsCategory in
            if page == 1 {
                weakSelf?.listItem = itemsCategory
            } else {
                weakSelf?.listItem.append(itemsCategory)
            }
            weakSelf?.view?.collectionView.reloadData()
        }).start()
    }

}

extension CategoryPresenterImplementation: CategoryPresenter {

    func setCategory(_ category: Category?) {
        self.category = category
        view?.displayLoading(isLoading: true)
        getListBook()
    }

}

extension CategoryPresenterImplementation: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return BookCollectionViewCell.fitSizeItem(withSize: collectionView.frame.size)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let book = listItem.data[safe: indexPath.row] else {
            return
        }
        router.showBookDetail(book)
    }

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath) {
        if indexPath.row == listItem.total - 1, let nextPage = listItem.nextPage {
            getListBook(page: nextPage)
        }
    }
}

extension CategoryPresenterImplementation: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listItem.data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
                        -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableNibCell(type: BookCollectionViewCell.self, atIndex: indexPath),
                let book = listItem.data[safe: indexPath.row] else {
            return UICollectionViewCell()
        }
        cell.displayBook(book: book)
        return cell
    }
}
