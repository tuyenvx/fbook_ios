//
//  BookRequestCell.swift
//  FBook
//
//  Created by Huy Pham on 9/20/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import UIKit

class BookRequestCell: UITableViewCell {

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    weak var presenter: BookRequestsPresenter?
    var request: BookRequest?

    @IBAction func onApproveTapped(_ sender: Any) {
        if let request = request {
            presenter?.approve(request)
        }
    }

    func display(request: BookRequest) {
        dateLabel.text = request.pivot?.createdAt?.toServerString()
        nameLabel.text = request.name
        emailLabel.text = request.email
        guard let status = BookingStatus(rawValue: request.pivot?.status ?? 0) else {
            statusLabel.text = nil
            approveButton.isHidden = true
            return
        }
        statusLabel.text = status.toString()
        statusLabel.textColor = status.color
        switch status {
        case .waiting, .returning:
            approveButton.setTitle("Approve", for: .normal)
            approveButton.isHidden = false
        case .reading:
            approveButton.setTitle("Unapprove", for: .normal)
            approveButton.isHidden = false
        case .returned, .cancel:
            approveButton.isHidden = true
        }
    }
}
