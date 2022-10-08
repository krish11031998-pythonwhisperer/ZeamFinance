//
//  PaymentModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

enum PaymentType: String {
	case bill
	case payment
	case installment
}

struct PaymentCardModel {
	let billCompany: String
	let billDescription: String
	let amount: Float
	let billCompanyLogo: UIImage
	let installmentsCount: Int?
	let totalInstallments: Int?
	let type: PaymentType
	
	
	init(billCompany: String,
		 billDescription: String,
		 amount: Float,
		 billCompanyLogo: UIImage,
		 installmentsCount: Int? = nil,
		 totalInstallments: Int? = nil,
		 type: PaymentType) {
		self.billCompany = billCompany
		self.billDescription = billDescription
		self.amount = amount
		self.billCompanyLogo = billCompanyLogo
		self.installmentsCount = installmentsCount
		self.totalInstallments = totalInstallments
		self.type = type
	}
}


extension PaymentType {
	var color: UIColor {
		switch self {
		case .bill:
			return .popWhite500
		case .payment:
			return .info100
		case .installment:
			return .manna100
		}
	}
	
	var imgCornerRadius: CGFloat {
		switch self {
		case .bill:
			return 0
		case .installment:
			return 12
		case .payment:
			return 24
		}
	}
}
