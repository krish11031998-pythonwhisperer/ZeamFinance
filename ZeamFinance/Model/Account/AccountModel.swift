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

extension Array where Element == AccountModel {
	static var testAccounts: [Self.Element] {
		[.init(accountId: UUID().uuidString, name: "AED Account", currency: "AED", balance: Float.random(in: 100..<1000)),
		 .init(accountId: UUID().uuidString, name: "BTC Account", currency: "BTC", balance: Float.random(in: 100..<1000), isCrypto: true),
		 .init(accountId: UUID().uuidString, name: "ZFI Account", currency: "ZFI", balance: Float.random(in: 100..<1000), isCrypto: true)]
	}
}

struct AccountCellModel: ActionProvider {
	let account: AccountModel
	var action: Callback?
}
