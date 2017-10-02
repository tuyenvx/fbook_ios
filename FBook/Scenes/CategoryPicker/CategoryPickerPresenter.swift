//
//  CategoryPickerPresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/27/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import RxSwift

protocol CategoryPickerView: class {
    weak var tableView: UITableView! { get }
    func showLoading()
    func hideLoading()
    func updateHeightTableView(height: CGFloat)
}

protocol CategoryPickerPresenterDelegate: class {
    func categoryPickerPresenter(didSelect category: Category?)
}

protocol CategoryPickerPresenter {
    func getCategories()
    func didSelectDismiss()
}

class CategoryPickerPresenterImplementation: NSObject {

    fileprivate let router: CategoryPickerRouter
    fileprivate weak var delegate: CategoryPickerPresenterDelegate?
    fileprivate weak var view: CategoryPickerView?
    fileprivate var categories: [Category] = []
    fileprivate var currentSelectedCategory: Category?
    fileprivate let disposeBag = DisposeBag()

    init(view: CategoryPickerView?, router: CategoryPickerRouter, delegate: CategoryPickerPresenterDelegate?,
         currentSelectedCategory: Category?) {
        self.view = view
        self.router = router
        self.delegate = delegate
        self.currentSelectedCategory = currentSelectedCategory
    }

    func reloadTable() {
        guard let tableView = view?.tableView else {
            return
        }
        tableView.registerNibCell(type: PickerTableViewCell.self)
        var listCategory: [Category?] = categories
        listCategory.insert(nil, at: 0) // Notes: add row "All"
        Observable.just(listCategory).bind(to: tableView.rx.items) { (tableView, _, category) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableNibCell(type: PickerTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.display(title: category?.name, isChecked: self.currentSelectedCategory?.id == category?.id)
            return cell
            }.disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            self?.currentSelectedCategory = listCategory[index.row]
            self?.delegate?.categoryPickerPresenter(didSelect: self?.currentSelectedCategory)
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self?.router.dismiss()
            }
        }).disposed(by: disposeBag)
    }
}

extension CategoryPickerPresenterImplementation: CategoryPickerPresenter {

    func getCategories() {
        weak var weakSelf = self
        view?.showLoading()
        CategoryProvider.getCategories().on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
        }, disposed: {
            weakSelf?.view?.hideLoading()
        }, value: { categories in
            guard let weakSelf = weakSelf, let tableView = weakSelf.view?.tableView else {
                return
            }
            weakSelf.categories.removeAll()
            weakSelf.categories.append(contentsOf: categories)
            weakSelf.reloadTable()
            weakSelf.view?.updateHeightTableView(height: tableView.contentSize.height)
        }).start()
    }

    func didSelectDismiss() {
        router.dismiss()
    }

}
