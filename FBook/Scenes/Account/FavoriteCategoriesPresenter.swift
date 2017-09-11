//
//  FavoriteCategoriesPresenter.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/11/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import UIKit

protocol FavoriteCategoriesView: class {
    func refreshCategories()
    func showLoadCategoriesError(message: String)
}

protocol FavoriteCategoriesPresenter: UITableViewDelegate {
    func getFavoriteCategories()
    func configure(tableView: UITableView)
}

class FavoriteCategoriesPresenterImplementation: NSObject {
    fileprivate weak var view: FavoriteCategoriesView?
    fileprivate var sectionCategories = [Category]()

    init(view: FavoriteCategoriesView) {
        self.view = view
    }

    fileprivate func handleLoadBookError(_ error: Error) {
        view?.showLoadCategoriesError(message: error.message)
    }

    fileprivate func handleLoadCategoriesSuccess(_ sectionCategories: [Category]) {
        self.sectionCategories.removeAll()
        self.sectionCategories.append(contentsOf: sectionCategories)
        view?.refreshCategories()
    }

}

extension FavoriteCategoriesPresenterImplementation: FavoriteCategoriesPresenter {
    func configure(tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getFavoriteCategories() {
        guard let user = User.currentUser else {return}
        UsersProvider.getFavoriteCategoriesOfCurrentUser(userId: user.id).on(failed: { error in
                self.handleLoadBookError(error)
            }, completed: {
            }, value: { categories in
                self.sectionCategories.append(contentsOf: categories)
                self.handleLoadCategoriesSuccess(self.sectionCategories)
            }).start()
    }
}

extension FavoriteCategoriesPresenterImplementation: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

extension FavoriteCategoriesPresenterImplementation: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCategories.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell") as?
            CategoryTableViewCell else {return UITableViewCell()}
        cell.updateCell(categoryName: self.sectionCategories[indexPath.section].name)
        return cell
    }
}
