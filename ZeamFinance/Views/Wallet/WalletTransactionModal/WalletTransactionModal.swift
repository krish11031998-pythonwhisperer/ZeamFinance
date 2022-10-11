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
	private var transaction: TransactionModel? { TransactionStorage.selectedTransaction }
	
	private lazy var tableView: UITableView = {
		let table = UITableView(frame: .zero, style: .grouped)
		table.showsVerticalScrollIndicator = false
		table.separatorStyle = .none
		return table
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
	}()
	
	private lazy var viewModel: WalletTransactionModalViewModel = {
		let model = WalletTransactionModalViewModel()
		model.view = self
		return model
	}()
	
	//MARK: - Overriden Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		view.cornerRadius(16, corners: .top)
		view.clipsToBounds = true
		setupView()
		setupNav()
		viewModel.loadView()
	}
	
	//MARK: - Protected Methods
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.backgroundColor = .surfaceBackground
		view.addShadow()
		preferredContentSize = .init(width: .totalWidth, height: .totalHeight)
		tableView.tableHeaderView = viewModel.tableHeader
		tableView.tableHeaderView?.frame = viewModel.tableHeader?.compressedSize.frame ?? .zero
	}
	
	@objc
	private func closeModal() {
		dismiss(animated: true) {
			TransactionStorage.selectedTransaction = nil
		}
	}
	
	private func setupNav() {
		standardNavBar(leftBarButton: .init(customView: "Transaction".sectionHeader(size: 20).generateLabel),
					   rightBarButton: .init(customView: closeButton), isTransparent: false)
		navigationController?.additionalSafeAreaInsets = .zero
	}
	
}

extension WalletTransactionModal: AnyTableView {
	
	func reloadTableWithDataSource(_ dataSource: TableViewDataSource) {
		tableView.reloadData(dataSource)
	}
}
