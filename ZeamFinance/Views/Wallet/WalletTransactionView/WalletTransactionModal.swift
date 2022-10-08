//
//  WalletTransactionModal.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

class WalletTransactionModal: UIViewController {
	
	//MARK: - Properties
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.separatorStyle = .none
		return table
	}()
	
	//MARK: - Overriden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		view.cornerRadius(16, corners: .top)
		view.clipsToBounds = true
		setupView()
		setupNav()
	}
	
	//MARK: - Protected Methods
	private var txnSection: TableSection? {
		guard let selectedTxn = TransactionStorage.selectedTransaction else { return nil }
		return .init(rows: Array(repeating: TableRow<TransactionCell>(.init(transaction: selectedTxn)), count: 4))
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [txnSection].compactMap { $0 })
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDatasource())
		tableView.backgroundColor = .surfaceBackground
		view.addShadow()
	}
	
	private func setupNav() {
		standardNavBar(title: "Transaction", leftBarButton: .init())
		navigationController?.additionalSafeAreaInsets = .init(top: 20, left: 0, bottom: 0, right: 0)
	}
	
}
