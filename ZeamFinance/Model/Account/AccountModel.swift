//
//  AccountModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation

struct AccountModel {
	let accountId: String
	let name: String
	let currency: String
	let balance: Float
	let isCrypto: Bool
	
	init(accountId: String, name: String, currency: String, balance: Float, isCrypto: Bool = false) {
		self.accountId = accountId
		self.name = name
		self.currency = currency
		self.balance = balance
		self.isCrypto = isCrypto
	}
}

struct AccountCellModel: ActionProvider {
	let account: AccountModel
	var action: Callback?
}
