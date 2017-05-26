//
//  UIViewController+Extension.swift
//  FBook
//
//  Created by admin on 5/18/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit
import PKHUD

extension UIViewController {
    
    func showAlertError(error: Error, title: String = "") {
        if let error = error as? ResponseError {
            self.showAlert(message: error.description, andTitle: title)
        }
        else {
            self.showAlert(message: error.localizedDescription , andTitle: title)
        }
    }
    
    func showAlert(message: String) {
        showAlert(message: message, andTitle: "")
    }
    
    func showAlert(message: String, andTitle title: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil ))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoTitleBackButton() {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "icon_back"), style: .done, target: self, action: #selector(self.popToPreviousViewController))
    }
    
    func popToPreviousViewController() {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func showNavigationBarTraparent() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
    }
    
    func showNavigationBarDefault() {
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func showLoading()  {
        DispatchQueue.main.async {
            HUD.show(HUDContentType.rotatingImage(#imageLiteral(resourceName: "icon_loading")))
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            HUD.hide(animated: true)
        }
    }
}
