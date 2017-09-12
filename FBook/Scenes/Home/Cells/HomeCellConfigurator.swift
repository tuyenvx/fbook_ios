//
//  HomeCellConfigurator.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

protocol HomeCellConfigurator {
    func configure(cell: HomeTableViewCell)
}

struct HomeCellConfiguratorImplementation {

    fileprivate let books: [Book]
    fileprivate weak var delegate: HomeCellPresenterDelegate?

    init(books: [Book], delegate: HomeCellPresenterDelegate?) {
        self.books = books
        self.delegate = delegate
    }

}

extension HomeCellConfiguratorImplementation: HomeCellConfigurator {

    func configure(cell: HomeTableViewCell) {
        let presenter = HomeCellPresenterImplementation(view: cell, books: books, delegate: delegate)
        cell.presenter = presenter
    }

}
