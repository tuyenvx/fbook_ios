//
//  WaitingRequestViewController.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class WaitingRequestViewController: UIViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!
    var presenter: WaitingRequestPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension WaitingRequestViewController: WaitingRequestView {
}
