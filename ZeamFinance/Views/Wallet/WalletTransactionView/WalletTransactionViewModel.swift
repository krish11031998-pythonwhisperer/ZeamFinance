//
//  WalletTransactionViewModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

extension Notification.Name {
	static let showTxn: Self = .init("showTxn")
}

class WalletTransactionViewModel {
	
	private var allTransactions: [TransactionModel]?
	public weak var view: AnyTableView?
	
	func loadTxns() {
		self.allTransactions = [.init(cellLogo: .IconCatalogue.amazon.image, detail: "amazon", amount: 250),
								.init(cellLogo: .IconCatalogue.netflix.image, detail: "netflix", amount: 50),
								.init(cellLogo: .IconCatalogue.zomato.image, detail: "zomato", amount: 80)]
		view?.reloadTableWithDataSource(buildDataSource())
	}

	private var txnsSection: TableSection? {
		guard let validTransaction = allTransactions else { return nil }
		
		return .init(rows: validTransaction.compactMap { txn in
			let model: TransactionCellModel = .init(transaction: txn){
				TransactionStorage.selectedTransaction = txn
				NotificationCenter.default.post(name: .showTxn, object: nil)
			}
			return TableRow<TransactionCell>(model)
		}, title: "Transactions")
	}
	
	private func buildDataSource() -> TableViewDataSource {
		.init(sections: [txnsSection].compactMap { $0 })
	}
	
}
