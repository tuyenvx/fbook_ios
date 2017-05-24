//
//  ChooseFilterViewController.swift
//  FBook
//
//  Created by admin on 5/23/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class ChooseFilterViewController: UIViewController {

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showNoTitleBackButton()
        
    }

}

extension ChooseFilterViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemChooseFilterCell", for: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: AppStoryboards.segueIdentifierShowChooseFilter, sender: nil)
    }
}
