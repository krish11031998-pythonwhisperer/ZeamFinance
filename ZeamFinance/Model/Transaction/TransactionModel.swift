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
	
	init(cellLogo: UIImage, detail: String, date: String = Date.now.ISO8601Format(), amount: Float) {
		self.cellLogo = cellLogo
		self.detail = detail
		self.date = date
		self.amount = amount
	}
}
