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
}
