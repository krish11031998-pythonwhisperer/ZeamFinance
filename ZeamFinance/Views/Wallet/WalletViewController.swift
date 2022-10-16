//
//  TransactionViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class WalletViewController: UIViewController {
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		table.showsVerticalScrollIndicator = false
		return table
	}()
	
	private lazy var viewModel: WalletViewModel = {
		let model = WalletViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		viewModel.loadData()
		setupView()
		addBindings()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		mainPageNavBar(title: "Wallet")
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
		viewModel.setupHeaderView()
	}
	
	func addBindings() {
		viewModel.addBindings(.showAnalytics) {
			self.navigationController?.pushViewController(SpendingAnalyticsViewController(), animated: true)
		}
		viewModel.addBindings(.showWallet) { [weak self] in
			self?.navigationController?.pushViewController(WalletTransactionViewController(), animated: true)
		}
	}
}

extension WalletViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
	
	func setupHeaderView(view: UIView) {
		tableView.tableHeaderView = view
		tableView.tableHeaderView?.frame = view.compressedSize.frame
	}
}
