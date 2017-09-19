//
//  WaitingRequestViewController.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class WaitingRequestViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet fileprivate weak var noDataView: NoDataView!
    fileprivate var configurator = WaitingRequestConfiguratorImplementation()
    var presenter: WaitingRequestPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter?.configureTableView()
        presenter?.fetchWaitingBook(1)
    }

}

extension WaitingRequestViewController: WaitingRequestView {

    func hideNoDataView(_ hide: Bool) {
        noDataView.isHidden = hide
    }
}
