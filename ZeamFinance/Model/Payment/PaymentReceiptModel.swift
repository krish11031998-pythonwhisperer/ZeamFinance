//
//  PaymentReceiptModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 13/10/2022.
//

import Foundation

struct PaymentReceiptModel: Codable {
	let description: String
	let unitPrice: Float
	let units: Float
}

extension PaymentReceiptModel: Hashable {
	
	func hash(into hasher: inout Hasher) {
		hasher.combine(description)
	}
}
