//
//  OfferModel.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 11/10/2022.
//

import Foundation
import UIKit

enum OfferType: String, CaseIterable {
	case traveling
	case gaming
	case subscriptions
	case none
}

extension OfferType {
	var selectedColor: UIColor {
		switch self {
		case .traveling:
			return .manna500
		case .gaming:
			return .info500
		case .subscriptions:
			return .orangeSunshine500
		default:
			return .surfaceBackground
		}
	}
	
	func selectedColors(_ isSelected: Bool) ->  UIColor {
		isSelected ? .popWhite500 : selectedColor
	}
	
	func backgroundColor(_ isSelected: Bool) -> UIColor {
		!isSelected ? .clear : selectedColor
	}
	
	func blobButton(_ offer: OfferType, handler: @escaping () -> Void) -> UIView {
		let isSelected = offer == self
		let backgroundColor = backgroundColor(isSelected)
		let inset: UIEdgeInsets = .init(vertical: 7.5, horizontal: 10)
		let view = rawValue.capitalized.medium(color: selectedColor, size: 12)
						   .generateLabel
						   .blobify(backgroundColor: backgroundColor, edgeInset: inset, borderColor: selectedColor, borderWidth: 1, cornerRadius: 8)
		return view.buttonify(handler: handler)
	}
}

struct OfferViewModel {
	let brandLogo: UIImage?
	let brandLogoImage: String?
	let brand: String?
	let offerDescription: String
	let background: UIImage?
	let backgroundUrl: String?
	let category: String?
	
	init(brandLogo: UIImage? = nil,
		 brandLogoImage: String? = nil,
		 brand: String? = nil,
		 category: String? = nil,
		 offerDescription: String,
		 background: UIImage? = nil,
		 backgroundUrl: String? = nil) {
		self.brandLogo = brandLogo
		self.brandLogoImage = brandLogoImage
		self.brand = brand
		self.offerDescription = offerDescription
		self.background = background
		self.backgroundUrl = backgroundUrl
		self.category = category
	}
}
