//
//  WaitingBooksViewController.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class WaitingBooksViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var noDataView: NoDataView!
    fileprivate var configurator = WaitingBooksConfiguratorImplementation()
    var presenter: WaitingBooksPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter?.configureTableView()
        presenter?.fetchWaitingBook(1)
    }

}

extension WaitingBooksViewController: WaitingBooksView {

    func hideNoDataView(_ hide: Bool) {
        noDataView.isHidden = hide
    }
}
