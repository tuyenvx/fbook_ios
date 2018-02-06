//
//  CustomActivityButton.swift
//  FBook
//
//  Created by TuyenVX on 2/5/18.
//  Copyright © 2018 Framgia. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class CustomActivityButton: UIButton {

    var name: Variable<String> = Variable<String>("")
    var count: Variable<Int> = Variable<Int>(0)
    private let disposeBag = DisposeBag()
    private var countLabel: UILabel = UILabel()
    private var nameLabel: UILabel  = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        setDefaults()
    }

    override func draw(_ rect: CGRect) {
        changeFrame()
        addObserverUI()
    }

    func setDefaults() {
        self.setImage(#imageLiteral(resourceName: "ic_activities"), for: .normal)
        nameLabel.textAlignment = .center
        nameLabel.font = titleLabel?.font
        nameLabel.text = titleLabel?.text
        nameLabel.textColor = .darkGray
        nameLabel.isUserInteractionEnabled = false
        self.insertSubview(nameLabel, at: 2)
        countLabel.font = UIFont.systemFont(ofSize: 14)
        countLabel.textColor = .white
        countLabel.textAlignment = .center
        countLabel.isUserInteractionEnabled = false
        self.insertSubview(countLabel, at: 2)
    }

    func addObserverUI() {
        name.asObservable().subscribe(onNext: { name in
            self.nameLabel.text = name
        }).addDisposableTo(disposeBag)
        count.asObservable().subscribe(onNext: { count in
            self.countLabel.text = String(count)
        }).addDisposableTo(disposeBag)
    }

    func changeFrame() {
        let width = self.frame.width
        let height = self.frame.height
        self.imageEdgeInsets = UIEdgeInsets.init(top: 10, left: 10, bottom: height / 3.0, right: 10)
        nameLabel.frame = CGRect(x: 0, y: height * 2 / 3.0, width: width, height: height / 3.0)
        countLabel.frame = CGRect(x: 0, y: height / 3.0 - 15 / 2.0, width: width, height: 15)
    }

    func config(_ name: String, _ count: Int) {
        self.name.value = name
        self.count.value = count
    }
}
