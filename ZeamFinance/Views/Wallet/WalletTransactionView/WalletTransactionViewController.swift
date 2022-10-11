//
//  TransactionsViewController.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class WalletTransactionViewController: UIViewController {

	//MARK: - Properties
	private lazy var viewModel: WalletTransactionViewModel = {
		let model = WalletTransactionViewModel()
		model.view = self
		return model
	}()
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.showsVerticalScrollIndicator = false
		table.separatorStyle = .none
		return table
	}()
	
	//MARK: - Overridden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		viewModel.loadTxns()
		standardNavBar()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
	}
	
	//MARK: - Protected Methods
	private func setupViews() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
	}
}


extension WalletTransactionViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
