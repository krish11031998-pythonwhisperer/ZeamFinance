//
//  PaymentModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

enum PaymentType: String, Codable {
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

struct PaymentQRCodeModel: Codable {
	let billCompany: String
	let billDescription: String
	let amount: Float
	let installmentsCount: Int?
	let totalInstallments: Int?
	let type: PaymentType
	
	init(billCompany: String, billDescription: String, amount: Float, installmentsCount: Int?, totalInstallments: Int?, type: PaymentType) {
		self.billCompany = billCompany
		self.billDescription = billDescription
		self.amount = amount
		self.installmentsCount = installmentsCount
		self.totalInstallments = totalInstallments
		self.type = type
	}
	
	init(paymentModel: PaymentCardModel) {
		self.billCompany = paymentModel.billCompany
		self.billDescription = paymentModel.billDescription
		self.amount = paymentModel.amount
		self.installmentsCount = paymentModel.installmentsCount
		self.totalInstallments = paymentModel.totalInstallments
		self.type = paymentModel.type
	}
	
}

extension PaymentType {
	var color: UIColor {
		switch self {
		case .bill:
			return .parkGreen500
		case .payment:
			return .info100
		case .installment:
			return .manna100
		}
	}
	
	var imgCornerRadius: CGFloat {
		switch self {
		case .bill:
			return 8
		case .installment:
			return 12
		case .payment:
			return 24
		}
	}
}


//MARK: - Example of PaymentCardModel
extension PaymentCardModel {
   
   static var dewa: PaymentCardModel {
	   .init(billCompany: "DEWA",
			 billDescription: "Utility Bill",
			 amount: Float.random(in: 100..<2000),
			 billCompanyLogo: .init(named: "DEWAImage") ?? .solid(color: .black), type: .bill)
   }
   
   static var person: PaymentCardModel {
	   .init(billCompany: "John",
			 billDescription: "Dinner",
			 amount: Float.random(in: 50..<100),
			 billCompanyLogo: .init(named: "person") ?? .solid(color: .black),
			 type: .payment)
   }
   
   static var installment: PaymentCardModel {
	   .init(billCompany: "Apple Inc.",
			 billDescription: "MacBook Pro",
			 amount: 2000,
			 billCompanyLogo: .init(named: "appleLogo") ?? .solid(color: .clear),
			 installmentsCount: 5,
			 totalInstallments: 12,
			 type: .installment)
   }
}
