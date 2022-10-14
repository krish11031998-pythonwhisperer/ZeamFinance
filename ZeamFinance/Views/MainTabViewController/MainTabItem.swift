//
//  MainTabItem.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 13/10/2022.
//

import Foundation
import UIKit

fileprivate extension UITabBarItem {
	convenience init(title: String, image: UIImage.TabBarImageCatalogue, selectedImage: UIImage.TabBarImageCatalogue) {
		self.init(title: title, image: image.image.resized(size: .init(squared: 24)), selectedImage: selectedImage.image.resized(size: .init(squared: 24)))
	}
}

enum MainTabBarModel {
	case home
	case wallet
	case offers
	case pay
	case profile
	case none
}

extension MainTabBarModel {
	
	var tabBarItem: UITabBarItem {
		switch self {
		case .home:
			return .init(title: "Home", image: .home,
										selectedImage: .homeSelected)
		case .wallet:
			return .init(title: "Wallet", image: .cards,
						 selectedImage: .cardsSelected)
		case .offers:
			return .init(title: "Offers", image: .shop,
						 selectedImage: .shopSelected)
		case .pay:
			return .init(title: "Pay", image: .pay,
						 selectedImage: .paySelected)
		case .profile:
			return .init(title: "Profile", image: .rewards,
						 selectedImage: .rewardsSelected)
		default:
			return .init(title: "ZUI", image: nil, selectedImage: nil)
		}
	}
	
}
