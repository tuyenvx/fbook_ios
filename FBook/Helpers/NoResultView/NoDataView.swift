//
//  NoDataView.swift
//  FBook
//
//  Created by Huy Pham on 9/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class NoDataView: UIView {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        if let views = Bundle.main.loadNibNamed("NoDataView", owner: self, options: nil) as? [UIView] {
            let view = views[0]
            view.frame = bounds
            addSubview(view)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        }
    }
}
