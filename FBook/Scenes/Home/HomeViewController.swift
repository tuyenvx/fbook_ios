//
//  HomeViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    @IBOutlet fileprivate weak var tableView: UITableView!

    var presenter: HomePresenter?
    var configurator: HomeConfigurator?

    override func viewDidLoad() {
        super.viewDidLoad()
        setDefaultRightButtons()
        addSearchButton()
        addLoginButton()
        configurator = HomeConfiguratorImplementation()
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
    }

    func setDefaultRightButtons() {
        guard let heightButton = navigationController?.navigationBar.frame.height else {
            return
        }
        let widthButton: CGFloat = 30
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: widthButton, height: heightButton)))
        button.setImage(#imageLiteral(resourceName: "ic_more"), for: .normal)
        button.addTarget(self, action: #selector(menuButtonTapped(_:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }

    @objc func menuButtonTapped(_ sender: Any) {
        var senderFrame = CGRect.zero
        if let senderView = sender as? UIView, let window = application.keyWindow {
            senderFrame = senderView.convert(senderView.frame, to: window)
        }
        presenter?.menuButtonTapped(senderFrame: senderFrame)
    }

    func addSearchButton() {
        let searchButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_search"), style: .plain, target: self,
            action: #selector(searchButtonTapped(_:)))
        navigationItem.leftBarButtonItem = searchButton
    }

    func addLoginButton() {
        if User.currentUser == nil {
            let loginButton = UIBarButtonItem(title: "Login", style: .plain, target: self,
                action: #selector(loginButtonTapped(_:)))
            loginButton.tintColor = .white
            var rightButtons = navigationItem.rightBarButtonItems ?? []
            rightButtons.append(loginButton)
            navigationItem.rightBarButtonItems = rightButtons
        }
    }

    @objc func searchButtonTapped(_ sender: Any) {
        presenter?.searchButtonTapped()
    }

    @objc func loginButtonTapped(_ sender: Any) {
        presenter?.loginButtonTapped()
    }
}

extension HomeViewController: HomeView {

    func refreshBooks() {
        tableView.reloadData()
    }

    func showLoadBooksError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }

}

extension HomeViewController: ChooseWorkspacePresenterDelegate {

    func didSelect(office: Office?) {
        presenter?.didChoseOffice()
    }

}
