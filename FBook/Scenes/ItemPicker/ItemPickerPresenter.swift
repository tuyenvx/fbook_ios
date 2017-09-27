//
//  ItemPickerPresenter.swift
//  FBook
//
//  Created by Thanh Nguyen Xuan on 9/26/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

protocol ItemPickerView: class {

}

protocol ItemPickerPresenter {

    func configure(pickerView: UIPickerView)

}

class ItemPickerPresenterImpl: NSObject {

    private(set) var router: ItemPickerViewRouter?
    fileprivate weak var view: ItemPickerView?

    var items: [String]

    init(view: ItemPickerView, router: ItemPickerViewRouter, items: [String]) {
        self.view = view
        self.router = router
        self.items = items
    }

}

// MARK: - ItemPickerPresenter

extension ItemPickerPresenterImpl: ItemPickerPresenter {

    func configure(pickerView: UIPickerView) {
        pickerView.dataSource = self
        pickerView.delegate = self
    }

}

// MARK: - UIPickerViewDataSource

extension ItemPickerPresenterImpl: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }

}

// MARK: UIPickerViewDelegate

extension ItemPickerPresenterImpl: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return items[safe: row]
    }

}
