//
//  CustomButtonConfigs.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

//MARK: - CustomButtonImage
public struct CustomButtonImage {
	let img: UIImage?
	let url: String?
	let size: CGSize?
	
	init(img: UIImage? = nil, url: String? = nil, size: CGSize? = nil) {
		self.img = img
		self.url = url
		self.size = size
	}
}

extension UIImageView {
	func configureImageView(_ model: CustomButtonImage?) {
		guard let validModel = model else { return }
		if let validImage = validModel.img {
			image = validImage
			isHidden = false
		} else if let validURL = validModel.url {
			UIImage.loadImage(url: validURL, at: self, path: \.image)
			isHidden = false
		}
		if let validSize = validModel.size {
			setFrame(validSize)
		}
	}
}

//MARK: - CustomButtonBorderStyling
public struct CustomButtonBorderStyling {
	let cornerRadius: CGFloat
	let borderWidth: CGFloat
	let borderColor: UIColor
	
	init(cornerRadius: CGFloat = 0, borderWidth: CGFloat = 1, borderColor: UIColor = .clear) {
		self.cornerRadius = cornerRadius
		self.borderWidth = borderWidth
		self.borderColor = borderColor
	}
}

//MARK: - CustomButtonType
public enum CustomButtonType {
	case `default`
	case slender
	case stroke(height: CGFloat = 40,
				borderColor: UIColor = .surfaceBackgroundInverse,
				borderWidth: CGFloat = 1,
				inset: UIEdgeInsets = .init(top: 8, left: 12, bottom: 12, right: 8))
}

public extension CustomButtonType {
	var height: CGFloat {
		switch self {
		case .default:
			return 48
		case .slender:
			return 40
		case .stroke(let height,_,_,_):
			return height
		}
	}
	
	var inset: UIEdgeInsets {
		switch self {
		case .default:
			return .init(vertical: 16, horizontal: 20)
		case .stroke(_,_,_,let edge):
			return edge
		case .slender:
			return .init(vertical: 12, horizontal: 20)
		}
	}
	
	var borderColor: UIColor {
		switch self {
		case .default, .slender:
			return .clear
		case .stroke(_, let borderColor,_,_):
			return borderColor
		}
	}
	
	var borderWidth: CGFloat {
		switch self {
		case .default, .slender:
			return 0
		case .stroke(_,_,let borderWidth,_):
			return borderWidth
		}
	}
}


//MARK: - CustomButtonConfig
public struct CustomButtonConfig {
	let title:RenderableText
	let trailingImg: CustomButtonImage?
	let leadingImg: CustomButtonImage?
	let backgroundColor: UIColor
	let buttonStyling: CustomButtonBorderStyling
	let buttonType: CustomButtonType
	let action: Callback?
	
	
	init(title: RenderableText,
		 trailingImg: CustomButtonImage? = nil,
		 leadingImg: CustomButtonImage? = nil,
		 backgroundColor: UIColor = .surfaceBackground,
		 buttonType: CustomButtonType = .default,
		 buttonStyling: CustomButtonBorderStyling = .init(),
		 action: Callback? = nil) {
		self.title = title
		self.trailingImg = trailingImg
		self.leadingImg = leadingImg
		self.backgroundColor = backgroundColor
		self.buttonType = buttonType
		self.buttonStyling = buttonStyling
		self.action = action
	}
}

