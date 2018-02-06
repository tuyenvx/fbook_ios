//
//  ShareByTableViewCellConfigurator.swift
//  FBook
//
//  Created by TuyenVX on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation

protocol ShareByTableViewConfigurator {
    func config(view: ShareByTableViewCell)
}

struct ShareByTableViewCellConfiguratorImplement {
    weak var delegate: ShareByTableViewCellDelegate?
    var owners: [BookRequest]

    init(owners: [BookRequest], delegate: ShareByTableViewCellDelegate?) {
        self.owners = owners
        self.delegate = delegate
    }
}

extension ShareByTableViewCellConfiguratorImplement: ShareByTableViewConfigurator {
    func config(view: ShareByTableViewCell) {
        let presenter = ShareByTableViewCellPresentImplement.init(view: view, owners: owners, delegate: delegate)
        view.presenter = presenter
    }
}
