//
//  ListBookViewController.swift
//  FBook
//
//  Created by admin on 5/22/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ListBooksViewController: UIViewController {

    enum ControllerType {
        case listNew
        case listView
        case listWaiting
    }
    
    var controllerType: ControllerType = .listNew  {
        didSet {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.showNavigationBarDefault()
    }
}
