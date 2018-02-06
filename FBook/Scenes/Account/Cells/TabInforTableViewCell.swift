//
//  TabInforTableViewCell.swift
//  FBook
//
//  Created by ThietTB on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import UIKit

class TabInforTableViewCell: UITableViewCell {

    @IBOutlet weak var sharing: CustomActivityButton!
    @IBOutlet weak var readingButton: CustomActivityButton!
    @IBOutlet weak var waitingButton: CustomActivityButton!
    @IBOutlet weak var returnButton: CustomActivityButton!
    @IBOutlet weak var reviewButton: CustomActivityButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.customButton()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func customButton(){
        self.sharing.config("Chia sẻ", 0)
        self.readingButton.config("Đang đọc", 0)
        self.waitingButton.config("Đang chờ", 0)
        self.returnButton.config("Đã trả lại", 0)
        self.reviewButton.config("Đã xem", 0)
    }
    
}
