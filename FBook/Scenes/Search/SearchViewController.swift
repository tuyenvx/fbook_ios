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

    @IBOutlet fileprivate weak var descriptionOptionButton: UIButton!
    @IBOutlet fileprivate weak var authorOptionButton: UIButton!
    @IBOutlet fileprivate weak var titleOptionButton: UIButton!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    @IBOutlet fileprivate weak var segmentControl: UISegmentedControl!
    fileprivate var configurator = SearchConfiguratorImplementation()
    var presenter: SearchPresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
    }

    @IBAction func onSearchTypeTapped(_ sender: UIButton) {
        presenter?.change(searchType: sender.tag)
    }

    @IBAction func onStoreChanged(_ sender: UISegmentedControl) {
        presenter?.change(store: sender.selectedSegmentIndex)
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

extension SearchViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfBooks ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchBookCell", for: indexPath) as?
                SearchBookCell else {
            return UITableViewCell()
        }
        presenter?.configure(cell: cell, forRow: indexPath.row)
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.select(row: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.change(searchText: searchText)
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        presenter?.search()
    }
}
