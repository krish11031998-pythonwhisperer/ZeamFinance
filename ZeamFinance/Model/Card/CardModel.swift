//
//  CardModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

struct CardModel {
	let bankName: String
	let cardNumber: String
	let name: String
	
	init(bankName: String, cardNumber: String = "1234 XXXX XXXX 2022", name: String) {
		self.bankName = bankName
		self.cardNumber = cardNumber
		self.name = name
	}
}

