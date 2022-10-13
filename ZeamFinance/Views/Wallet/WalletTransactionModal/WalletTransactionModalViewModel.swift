//
//  WalletTransactionModalViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 09/10/2022.
//

import Foundation
import UIKit

class WalletTransactionModalViewModel {
	
	private var transaction: TransactionModel? { TransactionStorage.selectedTransaction }
	
	public weak var view: AnyTableView?
	
	public var tableHeader: UIView? {
		guard let validTransaction = transaction else { return nil }
		let stackView = UIStackView.HStack(spacing: 12)
		let txnInfoLabel = DualLabel()
		txnInfoLabel.configureLabel(title: validTransaction.detail.capitalized.sectionHeader(size: 15),
									subTitle: String(format: "$ %.2f", validTransaction.amount).bold(size: 35))
		let imageView = validTransaction.cellLogo.imageView(size: .init(squared: 64))
		imageView.setFrame(.init(squared: 64))
		imageView.contentMode = .scaleAspectFit
		imageView.backgroundColor = .popWhite500
		imageView.border(color: .surfaceBackgroundInverse, borderWidth: 1, cornerRadius: 8)
		[txnInfoLabel, .spacer(), imageView].forEach(stackView.addArrangedSubview(_:))
		let headerView = stackView.embedInView(insets: .init(by: 15), priority: .needed)
		return headerView
	}
	
	public func loadView() {
		view?.reloadTableWithDataSource(buildDatasource())
	}
	
	//MARK: - Protected Methods
	
	private var pointsScores: TableSection? {
		guard let selectedPointScored = transaction?.amount else { return nil }
		let stack = UIStackView.HStack(spacing: 8)
		let imgView = UIImageView(image: .IconCatalogue.coins.image)
		imgView.setFrame(.init(squared: 48))
		let label = String(format: "%.2f", selectedPointScored).bold(size: 30).generateLabel
		[imgView, label, .spacer()].forEach(stack.addArrangedSubview(_:))
		return .init(rows: [TableRow<CustomTableCell>(.init(view: stack, inset: .init(vertical: 5, horizontal: 10)))],
					 title: "Zeam Coins Earned")
	}
	
	private var txnDetails: TableSection? {
		guard let validTransaction = transaction else { return nil}
		let stack: UIStackView = .VStack(spacing: 10)
		["Date": validTransaction.date,
		 "Detail": validTransaction.detail,
		 "Status": validTransaction.isCompleted ? "Completed" : "Unpaid"
		].forEach { row in
			let rowStack = UIStackView.HStack(spacing: 12)
			[ row.key.regular(size: 12).generateLabel,
			  .spacer(),
			  row.value.capitalized.regular(size: 12).generateLabel].forEach(rowStack.addArrangedSubview(_:))
			stack.addArrangedSubview(rowStack)
		}
		let stackView = stack.embedInView(insets: .init(by: 10))
		stackView.border(color: .surfaceBackgroundInverse, borderWidth: 0.5, cornerRadius: 12)
		return .init(rows: [TableRow<CustomTableCell>(.init(view: stackView, inset: .init(vertical: 0, horizontal: 10)))], title: "Transaction Detail")
	}
	
	private var txnSection: TableSection? {
		guard let selectedTxn = transaction else { return nil }
		return .init(rows: Array(repeating: TableRow<TransactionCell>(.init(transaction: selectedTxn)), count: 1))
	}
	
	private func buildDatasource() -> TableViewDataSource {
		.init(sections: [txnDetails, pointsScores].compactMap { $0 })
	}
	
	
}
