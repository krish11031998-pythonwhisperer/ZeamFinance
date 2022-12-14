//
//  TransactionModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

struct TransactionCellModel: ActionProvider {
	let transaction: TransactionModel
	var action:Callback?
	
	init(transaction: TransactionModel, action: Callback? = nil) {
		self.transaction = transaction
		self.action = action
	}
}

struct TransactionModel {
	let cellLogo: UIImage
	let detail: String
	let date: String
	let amount: Float
	let receiptModel: [PaymentReceiptModel]
	var isCompleted: Bool
	
	init(cellLogo: UIImage,
		 detail: String,
		 date: String = Date.now.ISO8601Format(),
		 amount: Float,
		 receiptModel: [PaymentReceiptModel] = [],
		 status: Bool = false) {
		self.cellLogo = cellLogo
		self.detail = detail
		self.date = date
		self.amount = amount
		self.receiptModel = receiptModel
		self.isCompleted = status
	}
}

struct TransactionDailyModel {
	let txns: [TransactionModel]
}

struct TransactionWeeklyModel {
	let daily: [TransactionDailyModel]
}

extension TransactionDailyModel {
	var total: Float {
		txns.compactMap { $0.amount }.reduce(0, +)
	}
}


extension TransactionWeeklyModel {
	var weeklyTransaction: [String : Float] {
		var txns: [String : Float] = [:]
		daily.forEach {
			guard let date = $0.txns.first?.date else { return }
			txns[date] = $0.total
		}
		return txns
	}
}
