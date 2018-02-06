//
//  PersonalViewController.swift
//  FBook
//
//  Created by ThietTB on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class PersonalViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    var configurator: PersonalConfigurator?
    var presenter: PersonalPresenter?
    fileprivate var pointTapScroll: CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if configurator == nil, let user = User.currentUser {
            configurator = PersonalConfiguratorImplementation(user: user)
        }
        configurator?.configure(viewController: self)
        presenter?.configure(tableView: tableView)
        tableView.separatorStyle = .none
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension PersonalViewController: PersonalView{
    func refreshPersonal() {
        tableView.reloadData()
    }
    
    func showLoadPersonalError(message: String) {
        Utility.shared.showMessage(message: message, completion: nil)
    }
}

