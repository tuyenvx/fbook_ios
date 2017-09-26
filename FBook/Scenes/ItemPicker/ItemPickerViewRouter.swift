//
//  ItemPickerViewRouter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import Foundation

protocol ItemPickerViewRouter {
    
}

class ItemPickerViewRouterImpl {
    
    fileprivate weak var viewController: ItemPickerViewController?
    
    init(viewController: ItemPickerViewController) {
        self.viewController = viewController
    }
    
}

extension ItemPickerViewRouterImpl: ItemPickerViewRouter {
    
}
