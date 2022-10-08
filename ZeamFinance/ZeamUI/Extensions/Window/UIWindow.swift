//
//  UIWindow.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 08/10/2022.
//

import Foundation
import UIKit

extension UIWindow {
	
	static var statusBarFrame: CGRect { UIApplication.main?.statusBarFrame ?? .zero }
	
	var safeArea: UIEdgeInsets {
		Self.key?.safeAreaInsets ?? .zero
	}
	
	static var key: UIWindow? {
		guard #available(iOS 13.0, *) else { return UIApplication.main?.keyWindow }
		let windows = UIApplication.main?.connectedScenes.compactMap({ $0 as? UIWindowScene }).first?.windows
		return windows?.first(where: { $0.isKeyWindow }) ?? windows?.last
	}
	
}
