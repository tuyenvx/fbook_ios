//
//  UserReviewPresenter.swift
//  FBook
//
//  Created by TuyenVX on 2/13/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol UserReviewView {
    var tableView: UITableView! { get }
}

protocol UserReviewPresenter {
    func config(tableView: UITableView)
    func addObserver()
    func review(bookID: Int, review: Review)
}

class UserReviewPresenterImplement {
    var view: UserReviewView?
    var reviews: [Review]?
    let disposeBag = DisposeBag()
    fileprivate var isLoading = false

    init(view: UserReviewView?, reviews: [Review]?) {
        self.view = view
        self.reviews = reviews
    }
}

extension UserReviewPresenterImplement: UserReviewPresenter {
    func config(tableView: UITableView) {

    }

    func addObserver() {
        guard let tableView = view?.tableView, let reviews = reviews else {
            return
        }
        tableView.registerNibCell(type: UserReviewTableViewCell.self)
        Observable.just(reviews).bind(to: tableView.rx.items) { (tableView, _, review) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableNibCell(type: UserReviewTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.updateUI(review: review)
            return cell
        }.disposed(by: disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: {[weak self] index in
            // Handle when selected cell at index
            print("Did Select row at index: \(index)")
        }).disposed(by: disposeBag)
    }

    func review(bookID: Int, review: Review) {
        if isLoading {
            return
        }
        isLoading = true
        weak var weakSelf = self
        BookProvider.reviewBook(bookId: bookID, review: review).on(failed: { error in
            //
        }, completed: {
            //
        }, disposed: {
            //
        }, value: { review in
            //
        }).start()    }
}
