//
//  Notification.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation

extension Notification.Name {
	static let readQRCode: Self = .init("readQRCode")
	static let showTxn: Self = .init("showTxn")
	static let showPayment: Self = .init("showPayment")
	static let showCard: Self = .init("showCard")
	static let showAccount: Self = .init("showAccount")
	static let showAllTransactions: Self = .init("showAllTransactions")
	static let selectedAccount: Self = .init("selectedAccount")
	static let showAccounts: Self = .init("showAccounts")
	
	static let showAllTrendingOffersTab: Self = .init("showAllTrendingOffersTab")
}
