//
//  MainTabView.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 07/10/2022.
//

import Foundation
import UIKit

class MainTabView: UITabBar {

	private var shapeLayer: CAShapeLayer?

	override func draw(_ rect: CGRect) {
		let path = UIBezierPath(roundedRect: rect, cornerRadius: 16)
		let shape = CAShapeLayer()
		shape.path = path.cgPath
		shape.strokeColor = UIColor.clear.cgColor
		shape.fillColor = UIColor.surfaceBackground.cgColor
		shape.shadowColor = UIColor.surfaceBackgroundInverse.cgColor
		shape.shadowOpacity = 0.35
		shape.shadowOffset = .init(width: 0, height: 1.5)
		shape.shadowRadius = 5
		shape.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
		if shapeLayer == nil {
			shapeLayer = shape
		} else {
			shapeLayer?.removeFromSuperlayer()
		}
		layer.insertSublayer(shape, at: 0)
		shapeLayer = shape
	}
}
