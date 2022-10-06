//
//  SystemCatalogue.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 04/10/2022.
//

import Foundation
import UIKit

public extension UIImage {
	
	enum SystemCatalogue: String {
		case buttonLeftArrow
		case buttonRightArrow
		case chevronDown
		case chevronUp
		case chevronRight
		case leftArrow
		case rightArrow
		case navLeftArrow
		case navRightArrow
	}
	
	enum IconCatalogue: String {
		case amazon
		case netflix
		case zomato
		case card
		case cardLarge
	}
	
	enum ImageCatalogue: String {
		case profileImage
	}
	
	static var buttonLeftArrow: UIImage { .SystemCatalogue.buttonLeftArrow.image.resized(size: .init(width: 20, height: 8))}
	static var buttonRightArrow: UIImage { .SystemCatalogue.buttonRightArrow.image.resized(size: .init(width: 20, height: 8))}
	//static var buttonLeftArrow: UIImage { .SystemCatalogue.buttonLeftArrow.resized(size: .init(width: 20, height: 8))}
	//static var buttonLeftArrow: UIImage { .SystemCatalogue.buttonLeftArrow.resized(size: .init(width: 20, height: 8))}
}


public extension UIImage.IconCatalogue {
	var image: UIImage { .init(named: rawValue) ?? .solid(color: .black) }
}

public extension UIImage.SystemCatalogue {
	var image: UIImage { .init(named: rawValue) ?? .solid(color: .black) }
}

public extension UIImage.ImageCatalogue {
	var image: UIImage { .init(named: rawValue) ?? .solid(color: .black) }
}
