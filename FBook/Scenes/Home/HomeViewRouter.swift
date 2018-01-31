//
//  HomeViewRouter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/8/17.
//  Copyright (c) 2017 Framgia. All rights reserved.
//

import UIKit
import SafariServices


protocol HomeViewRouter {
    func showSearchScreen()
    func showLoginScreen()
    func showDetailBook(_ book: Book)
    func showSeeMoreSectionBook(_ sectionBook: SectionBook)
    func showMenuSetting(delegate: MenuSettingPresenterDelegate, senderFrame: CGRect)
    func showWorkspace()
    func dismiss()
    func showFeedback()
    func showMoreTools()}

struct HomeViewRouterImplementation {

    fileprivate weak var viewController: HomeViewController?

    init(viewController: HomeViewController?) {
        self.viewController = viewController
    }

    @discardableResult fileprivate func openSafariViewController(urlString: String) -> Bool {
        guard let url = URL(string: urlString) else {
            return false
        }
        let safariViewController = FBSafariViewController(url: url)
        viewController?.present(safariViewController, animated: true, completion: nil)
        return true
    }

}

extension HomeViewRouterImplementation: HomeViewRouter {

    func showSearchScreen() {
        if let searchViewController = UIStoryboard.search.instantiateInitialViewController() {
            viewController?.navigationController?.pushViewController(searchViewController, animated: true)
        }
    }

    func showLoginScreen() {
        if let loginViewController = UIStoryboard.login.instantiateInitialViewController() {
            viewController?.present(loginViewController, animated: true, completion: nil)
        }
    }

    func showDetailBook(_ book: Book) {
        guard let detailViewController = UIStoryboard.bookDetail.instantiateInitialViewController()
                as? BookDetailViewController else {
            return
        }
        detailViewController.configurator = BookDetailConfiguratorImplementation(book: book)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }

    func showSeeMoreSectionBook(_ sectionBook: SectionBook) {
        guard let sectionBookViewController = UIStoryboard.home
                .instantiateViewController(withIdentifier: "SectionBookViewController")
                as? SectionBookViewController else {
            return
        }
        sectionBookViewController.configurator = SectionBookConfiguratorImplementation(sectionBook: sectionBook)
        viewController?.navigationController?.pushViewController(sectionBookViewController, animated: true)
    }

    func showMenuSetting(delegate: MenuSettingPresenterDelegate, senderFrame: CGRect) {
        let menu = MenuSettingViewController(nibName: "MenuSettingViewController", bundle: nil)
        menu.modalPresentationStyle = .overFullScreen
        let configurator = MenuConfiguratorImplementation(delegate: delegate, senderFrame: senderFrame)
        menu.configurator = configurator
        viewController?.present(menu, animated: false, completion: nil)
    }

    func showWorkspace() {
        let workspace = ChooseWorkspaceViewController(nibName: "ChooseWorkspaceViewController", bundle: nil)
        workspace.configurator = ChooseWorkspaceConfiguratorImplementation(delegate: viewController)
        workspace.modalPresentationStyle = .overFullScreen
        viewController?.present(workspace, animated: false, completion: nil)
    }

    func showFeedback() {
        openSafariViewController(urlString: kFeedbackURL)
    }

    func showMoreTools() {
        openSafariViewController(urlString: kMoreToolsURL)
    }

    func dismiss() {
        viewController?.navigationController?.dismiss(animated: true, completion: nil)
    }
}
