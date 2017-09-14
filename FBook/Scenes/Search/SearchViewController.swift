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

class SearchViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var descriptionOptionButton: UIButton!
    @IBOutlet fileprivate weak var authorOptionButton: UIButton!
    @IBOutlet fileprivate weak var titleOptionButton: UIButton!
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

    @IBAction func onSearchTypeTapped(_ sender: UIButton) {
        presenter?.change(searchType: sender.tag)
    }

    @IBAction func onStoreChanged(_ sender: UISegmentedControl) {
        presenter?.change(store: sender.selectedSegmentIndex)
    }

    @IBAction func onScreenTapped(_ sender: Any) {
        presenter?.dismissKeyboard()
    }

}

extension SearchViewController: SearchView {

    func updateSearchType(_ type: SearchType) {
        titleOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_off"), for: .normal)
        authorOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_off"), for: .normal)
        descriptionOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_off"), for: .normal)
        switch type {
        case .title:
            titleOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_on"), for: .normal)
        case .author:
            authorOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_on"), for: .normal)
        case .description:
            descriptionOptionButton.setImage(#imageLiteral(resourceName: "ic_radio_on"), for: .normal)
        }
    }
}
