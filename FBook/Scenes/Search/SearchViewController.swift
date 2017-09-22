//
//  SearchViewController.swift
//  FBook
//
//  Created by Huy Pham on 9/8/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: BaseViewController {

    @IBOutlet weak var noDataView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var segmentControl: UISegmentedControl!
    fileprivate var configurator = SearchConfiguratorImplementation()
    var presenter: SearchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter?.configureTableView()
        presenter?.configureSearchBar()
        presenter?.configureObserver()
    }

    @IBAction func onSearchTypeChange(_ sender: UISegmentedControl) {
        presenter?.change(searchType: sender.selectedSegmentIndex)
    }

    @IBAction func onStoreChanged(_ sender: UISegmentedControl) {
        presenter?.change(store: sender.selectedSegmentIndex)
    }

    @IBAction func onScreenTapped(_ sender: Any) {
        presenter?.dismissKeyboard()
    }

}

extension SearchViewController: SearchView {

    func hideNoDataView(_ hide: Bool) {
        noDataView.isHidden = hide
    }
}
