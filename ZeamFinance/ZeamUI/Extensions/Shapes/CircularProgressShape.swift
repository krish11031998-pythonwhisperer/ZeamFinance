//
//  CircularProgressShape.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

extension CALayer {
	@discardableResult
	func addCircularProgress(startAngle: CGFloat,
							 endAngle: CGFloat,
							 radiusOffset: CGFloat = 0,
							 lineWidth: CGFloat,
							 strokeColor: UIColor,
							 clockwise: Bool,
							 animateStrokeEnd: Bool) -> CAShapeLayer {
		let rect = bounds
		let radius = min(rect.width, rect.height).half + radiusOffset
		let path = UIBezierPath()
		path.addArc(withCenter: rect.center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
		
		let shape = CAShapeLayer()
		shape.path = path.cgPath
		shape.fillColor = UIColor.clear.cgColor
		shape.strokeColor = strokeColor.cgColor
		shape.lineWidth = lineWidth
		shape.strokeStart = 0
		shape.strokeEnd = animateStrokeEnd ? 0 : 1
		
		addSublayer(shape)
		
		return shape
	}
	
}
