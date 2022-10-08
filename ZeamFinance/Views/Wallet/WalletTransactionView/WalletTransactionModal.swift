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
		table.separatorStyle = .none
		return table
	}()
	
	private lazy var closeButton: UIButton = {
		let button = UIButton(frame: .init(origin: .zero, size: .init(squared: 25)))
		button.setImage(.init(systemName: "xmark")?.withTintColor(.surfaceBackgroundInverse, renderingMode: .alwaysOriginal), for: .normal)
		button.addTarget(self, action: #selector(closeModal), for: .touchUpInside)
		return button
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
		return .init(rows: Array(repeating: TableRow<TransactionCell>(.init(transaction: selectedTxn)), count: 1))
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [txnSection].compactMap { $0 })
	}
	
	private func setupView() {
		view.addSubview(tableView)
		view.setFittingConstraints(childView: tableView, insets: .zero)
		tableView.reloadData(buildDatasource())
		tableView.backgroundColor = .surfaceBackground
		setupTableHeader()
		view.addShadow()
		preferredContentSize = .init(width: .totalWidth, height: .totalHeight)
	}
	
	private func setupTableHeader() {
		guard let validTransaction = transaction else { return }
		let stackView = UIStackView.HStack(spacing: 12)
		let txnInfoLabel = DualLabel()
		txnInfoLabel.configureLabel(title: validTransaction.detail.capitalized.sectionHeader(size: 15),
									subTitle: String(format: "$ %.2f", validTransaction.amount).bold(size: 35))
		let imageView = validTransaction.cellLogo.imageView(size: .init(squared: 64))
		imageView.setFrame(.init(squared: 64))
		imageView.contentMode = .center
		imageView.backgroundColor = .popWhite500
		imageView.border(color: .surfaceBackgroundInverse, borderWidth: 1, cornerRadius: 8)
		[txnInfoLabel, .spacer(), imageView].forEach(stackView.addArrangedSubview(_:))
		let headerView = stackView.embedInView(insets: .init(by: 15), priority: .needed)
		tableView.tableHeaderView = headerView
		tableView.tableHeaderView?.frame = headerView.compressedSize.frame
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
