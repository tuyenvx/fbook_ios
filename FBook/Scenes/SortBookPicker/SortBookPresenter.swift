//
//  SortBookPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SortBookView: class {
}

protocol SortBookPresenterDelegate: class {
    func sortBookPresenter(didSelect sort: SortType)
}

protocol SortBookPresenter {
    func configure(tableView: UITableView)
    func didSelectDismiss()
}

class SortBookPresenterImplementation: NSObject {

    fileprivate let router: SortBookRouter
    fileprivate weak var delegate: SortBookPresenterDelegate?
    fileprivate weak var view: SortBookView?
    fileprivate let listSort: [SortType] = [.title, .countView, .avgStar, .publishDate, .author, .createdAt]
    fileprivate var currentSelectedSort: SortType
    fileprivate let disposeBag = DisposeBag()

    init(view: SortBookView?, router: SortBookRouter, delegate: SortBookPresenterDelegate?,
         currentSelectedSort: SortType) {
        self.view = view
        self.router = router
        self.delegate = delegate
        self.currentSelectedSort = currentSelectedSort
    }
}

extension SortBookPresenterImplementation: SortBookPresenter {

    func configure(tableView: UITableView) {
        tableView.registerNibCell(type: PickerTableViewCell.self)
        Observable.just(listSort).bind(to: tableView.rx.items) { (tableView, _, sortType) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableNibCell(type: PickerTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.display(title: sortType.getTitle(), isChecked: self.currentSelectedSort == sortType)
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.modelSelected(SortType.self).subscribe { [weak self] event in
            guard let sortType = event.element else {
                return
            }
            self?.currentSelectedSort = sortType
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self?.router.dismiss()
                self?.delegate?.sortBookPresenter(didSelect: sortType)
            }
        }.disposed(by: disposeBag)
    }

    func didSelectDismiss() {
        router.dismiss()
    }
}
