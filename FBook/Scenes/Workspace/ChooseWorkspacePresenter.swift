//
//  ChooseWorkspacePresenter.swift
//  FBook
//
//  Created by Ban Nguyen Ngoc on 9/14/17.
//  Copyright © 2017 Framgia. All rights reserved.
//

import RxSwift

protocol ChooseWorkspaceView: class {
    weak var tableView: UITableView! { get }
    func showLoading()
    func hideLoading()
    func updateHeightTableView(height: CGFloat)
}

protocol ChooseWorkspacePresenterDelegate: AnyObject {
    func didSelect(office: Office?)
}

protocol ChooseWorkspacePresenter {
    func didSelectDismiss()
}

class ChooseWorkspacePresenterImplementation {

    fileprivate let router: ChooseWorkspaceRouter?
    fileprivate weak var view: ChooseWorkspaceView?
    fileprivate weak var delegate: ChooseWorkspacePresenterDelegate?
    fileprivate var offices: [Office] = []
    fileprivate let disposeBag = DisposeBag()

    init(view: ChooseWorkspaceView?, router: ChooseWorkspaceRouter?, delegate: ChooseWorkspacePresenterDelegate?) {
        self.view = view
        self.router = router
        self.delegate = delegate
        configureTableView()
        getListOffice()
    }

    fileprivate func configureTableView() {
        view?.tableView.registerNibCell(type: ChooseWorkspaceTableViewCell.self)
    }

    fileprivate func getListOffice() {
        view?.showLoading()
        weak var weakSelf = self
        OfficeProvider.getListOffice().on(failed: { error in
            Utility.shared.showMessage(message: error.message, completion: nil)
            weakSelf?.view?.hideLoading()
        }, completed: {
            weakSelf?.view?.hideLoading()
        }, value: { offices in
            guard let weakSelf = weakSelf, let tableView = weakSelf.view?.tableView else {
                return
            }
            weakSelf.offices.append(contentsOf: offices)
            weakSelf.reloadTable()
            weakSelf.view?.updateHeightTableView(height: tableView.contentSize.height)
        }).start()
    }

    fileprivate func reloadTable() {
        guard let tableView = view?.tableView else {
            return
        }
        var offices: [Office?] = self.offices
        offices.insert(nil, at: 0) // Notes: Adding row: "All"
        Observable.just(offices).bind(to: tableView.rx.items) { (tableView, _, office) -> UITableViewCell in
            guard let cell = tableView.dequeueReusableNibCell(type: ChooseWorkspaceTableViewCell.self) else {
                return UITableViewCell()
            }
            cell.displayOffice(office, isChecked: Office.currentId == office?.id)
            return cell
        }.addDisposableTo(disposeBag)
        tableView.rx.itemSelected.subscribe(onNext: { [weak self] index in
            let office: Office? = offices[index.row]
            Office.currentId = office?.id
            self?.delegate?.didSelect(office: office)
            tableView.reloadData()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                self?.router?.dismiss()
            }
        }).addDisposableTo(disposeBag)
    }
}

extension ChooseWorkspacePresenterImplementation: ChooseWorkspacePresenter {

    func didSelectDismiss() {
        router?.dismiss()
    }

}
