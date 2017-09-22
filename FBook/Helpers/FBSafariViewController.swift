//
//  FBSafariViewController.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation
import SafariServices

class FBSafariViewController: SFSafariViewController {

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        application.statusBarStyle = .default
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        application.statusBarStyle = .lightContent
    }

}
