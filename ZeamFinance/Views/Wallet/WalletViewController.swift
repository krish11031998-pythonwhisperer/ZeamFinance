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
		return table
	}()
	
	private lazy var viewModel: WalletViewModel = {
		let model = WalletViewModel()
		model.view = self
		return model
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupView()
		viewModel.loadData()
		setupTransparentNavBar()
		addObservers()
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
	}
	
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(showTransactions), name: .showAllTransactions, object: nil)
	}
	
	@objc
	private func showTransactions() {
		navigationController?.pushViewController(WalletTransactionViewController(), animated: true)
	}
}

extension WalletViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
