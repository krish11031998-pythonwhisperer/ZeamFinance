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
		table.separatorStyle = .none
		return table
	}()
	
	//MARK: - Overridden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		setupViews()
		viewModel.loadTxns()
		standardNavBar()
		addObservers()
	}
	
	//MARK: - Protected Methods
	private func setupViews() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
	}
	
	private func addObservers() {
		NotificationCenter.default.addObserver(self, selector: #selector(showModal), name: .showTxn, object: nil)
	}
	
	@objc
	private func showModal() {
		presentCard(controller: WalletTransactionModal(), withNavigation: true) {
			print("(DEBUG) On Dismissal is called!")
		}
	}
	
}


extension WalletTransactionViewController: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
