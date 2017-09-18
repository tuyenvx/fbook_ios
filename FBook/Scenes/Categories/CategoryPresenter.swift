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
}

protocol CategoryPresenter: class {
}

class CategoryPresenterImplementation {

    fileprivate weak var view: CategoryView?
    fileprivate let router: CategoryRouter
    fileprivate var category: Category?

    init(view: CategoryView, router: CategoryRouter) {
        self.view = view
        self.router = router
        configure()
        getListBook()
    }

    func setCategory(_ category: Category?) {
        self.category = category
        getListBook()
    }

    fileprivate func configure() {
        view?.collectionView.registerNibCell(type: BookCollectionViewCell.self)
        // TODO: add delegate, dataSource
    }

    fileprivate func getListBook() {
        // TODO: call API
    }

}

extension CategoryPresenterImplementation: CategoryPresenter {

}
