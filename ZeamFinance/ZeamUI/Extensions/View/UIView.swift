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


//MARK: - Array of views

extension Array where Element : UIView {
	
	func addToView(_ main: UIView) {
		if let stack = main as? UIStackView {
			forEach(stack.addArrangedSubview(_:))
		} else {
			forEach(main.addSubview(_:))
		}
	}
	
}
