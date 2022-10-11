//
//  UIFont.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

enum CustomFonts:String{
	case black = "Satoshi-Black"
	case bold = "Satoshi-Bold"
	case regular = "Satoshi-Regular"
	case medium = "Satoshi-Medium"
	case light = "Satoshi-Light"
	case sectionHeader = "PPCirka-Bold"
	//case sectionHeader = "Gilroy-Light"
	//case sectionHeader = "Gilroy-Bold"
	
	func fontBuilder(size: CGFloat) -> UIFont? {
		.init(name: self.rawValue, size: size)
	}
}

extension String {
	
	func regular(color: UIColor = .textColor, size: CGFloat) -> RenderableText  { styled(font: .regular, color: color, size: size) }
	func medium(color: UIColor = .textColor, size: CGFloat) -> RenderableText  { styled(font: .medium, color: color, size: size) }
	func semiBold(color: UIColor = .textColor, size: CGFloat) -> RenderableText  { styled(font: .regular, color: color, size: size) }
	func bold(color: UIColor = .textColor, size: CGFloat) -> RenderableText  { styled(font: .bold, color: color, size: size) }
	func extraBold(color: UIColor = .textColor, size: CGFloat) -> RenderableText  { styled(font: .black, color: color, size: size) }
	func sectionHeader(color: UIColor = .textColor, size: CGFloat) -> RenderableText { styled(font: .sectionHeader, color: color, size: size)}
}
