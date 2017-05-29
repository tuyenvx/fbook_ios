//
//  UICollectionViewController+Extension.swift
//  FBook
//
//  Created by admin on 5/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import MJRefresh

extension UICollectionViewController {
    
    func setupPullToRefresh() {
        collectionView?.setupPullToRefresh()
    }
    
    func setupLoadMore() {
        collectionView?.setupLoadMore()
    }
}

extension UICollectionView {
    
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
