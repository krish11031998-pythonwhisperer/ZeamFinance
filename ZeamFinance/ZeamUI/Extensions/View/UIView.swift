//
//  UIView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 14/10/2022.
//

import Foundation
import UIKit

extension UIView {
	
	func background(_ bgColor: UIColor = .surfaceBackgroundInverse) -> UIView {
		let bgView = UIView()
		bgView.backgroundColor = bgColor
		bgView.clippedCornerRadius = 8
		bgView.addSubview(self)
		bgView.setFittingConstraints(childView: self, insets: .init(by: 5))
		return bgView
	}
}
