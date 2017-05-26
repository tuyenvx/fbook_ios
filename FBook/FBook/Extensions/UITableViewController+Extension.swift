//
//  UITableViewController+Extension.swift
//  FBook
//
//  Created by admin on 5/25/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import MJRefresh

var RefreshHeaderKey = "RefreshHeaderKey"
var RefreshFooterKey = "RefreshFooterKey"
var RefreshOverlayKey = "RefreshOverlayKey"

extension UITableViewController {
    
    func setupPullToRefresh() {
        tableView.setupPullToRefresh()
    }
    
    func setupLoadMore() {
        tableView.setupLoadMore()
    }
}

extension UITableView {
    
    func setupPullToRefresh() {
        let header = MJRefreshNormalHeader()
//        header.lastUpdatedTimeLabel?.isHidden = true
//        header.stateLabel?.isHidden = true
        self.mj_header = header
    }
    
    func setupLoadMore() {
        let footer = MJRefreshBackNormalFooter()
        footer.stateLabel?.isHidden = true
        self.mj_footer = footer
    }
}
