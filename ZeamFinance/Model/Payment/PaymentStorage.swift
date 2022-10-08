//
//  PaymentStorgge.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation

extension Notification.Name {
	static let showPayment: Self = .init("showPayment")
}

class PaymentStorage {
	static var selectedPayment: PaymentCardModel? = nil
}
