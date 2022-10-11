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
}

struct AccountCellModel: ActionProvider {
	let account: AccountModel
	var action: Callback?
}
