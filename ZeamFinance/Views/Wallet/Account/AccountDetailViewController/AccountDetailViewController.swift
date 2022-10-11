//
//  AccountDetailViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

class AccountDetailViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let tableView: UITableView = .init(frame: .zero, style: .grouped)
		tableView.backgroundColor = .surfaceBackground
		tableView.separatorStyle = .none
		tableView.showsVerticalScrollIndicator = false
		return tableView
	}()
	
	private lazy var viewModel: AccountDetailViewModel = {
		let model = AccountDetailViewModel()
		model.view = self
		return model
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
	}()
	
	@objc
	private func closeModal() {
		dismiss(animated: true) {
			AccountStorage.selectedAccount = nil
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		standardNavBar(leftBarButton: .init(customView: "Account Detail".sectionHeader(size: 20).generateLabel),
					   rightBarButton: .init(customView: closeButton), isTransparent: false)
		preferredContentSize = .init(width: .totalWidth, height: .totalHeight)
		viewModel.loadData()
	}

	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
	}
}


extension AccountDetailViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
	
	func setupHeaderView(view: UIView) {
		tableView.tableHeaderView = view
		tableView.tableHeaderView?.frame = view.compressedSize.frame
	}
}
