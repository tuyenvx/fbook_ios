//
//  FollowersPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

protocol FollowersView: class {
    func showLoadFollowersError(message: String)
}

protocol FollowersPresenter {
    func getListFollowersUser(tableView: UITableView)
}

class FollowersPresenterImplementation: NSObject {
    fileprivate weak var view: FollowersView?
    fileprivate var listFollowers = [User]()
    let disposeBag = DisposeBag()

    init(view: FollowersView) {
        self.view = view
    }

    fileprivate func handleLoadFollowersUserError(_ error: Error) {
        view?.showLoadFollowersError(message: error.message)
    }
}

extension FollowersPresenterImplementation: FollowersPresenter {

    func getListFollowersUser(tableView: UITableView) {
        weak var weakSelf = self
        AlertHelper.showLoading()
        UsersProvider.getFollowersOfUser(userId: 1).on(failed: { error in
            AlertHelper.hideLoading()
            weakSelf?.handleLoadFollowersUserError(error)
        }, completed: {
            AlertHelper.hideLoading()
        }, value: { listUsers in
            Observable.just(listUsers)
                .bind(to: tableView.rx.items(cellIdentifier: "followerCell",
                                             cellType: FollowerTableViewCell.self)) { (index, user, cell) in
                                                cell.updateCell(user: user)
                }
                .disposed(by: self.disposeBag)
        }).start()
    }
}
