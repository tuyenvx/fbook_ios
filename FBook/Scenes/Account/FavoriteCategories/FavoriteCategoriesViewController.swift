//
//  KindOfBookViewController.swift
//  FBook
//
//  Created by tran.xuan.diep on 9/6/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class FavoriteCategoriesViewController: BaseViewController {

    @IBOutlet weak var favoriteCategoriesTableView: UITableView!
    var configurator: FavoriteCategoriesConfigurator?
    var presenter: FavoriteCategoriesPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator = FavoriteCategoriesConfiguratorImplementation()
        configurator?.configure(viewController: self)
        presenter.configure(tableView: favoriteCategoriesTableView)
        presenter.getFavoriteCategories()
    }
}

extension FavoriteCategoriesViewController: FavoriteCategoriesView {

    func refreshCategories() {
        favoriteCategoriesTableView.reloadData()
    }

    func showLoadCategoriesError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }
}
