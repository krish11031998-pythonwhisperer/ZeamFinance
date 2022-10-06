//
//  CuratedBackgroundShape.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit

extension CALayer {
	
	func addCuratedCornerShape(color: UIColor) {
		let rect = bounds
		let radius: CGFloat = 16
		let path: UIBezierPath = .init()
		path.move(to: .init(x: rect.maxX - radius, y: rect.maxY))
		path.addArc(withCenter: .init(x: rect.maxX - radius, y: rect.maxY - radius), radius: radius, startAngle: .pi.half, endAngle: .zero, clockwise: false)
		path.addLine(to: .init(x: rect.maxX, y: rect.minY + radius))
		path.addArc(withCenter: .init(x: rect.maxX - radius, y: rect.minY + radius), radius: radius, startAngle: .zero, endAngle: -.pi * 7.75/12.0, clockwise: false)
		path.addArc(withCenter: .init(x: rect.midX, y: rect.minY), radius: radius, startAngle: .pi * 0.4, endAngle: .pi * 0.6, clockwise: true)
		path.addArc(withCenter: .init(x: rect.minX + radius, y: rect.minY + radius), radius: radius, startAngle: -.pi * 4.25/12.0, endAngle: -.pi, clockwise: false)
		path.addLine(to: .init(x: rect.minX, y: rect.maxY - radius))
		path.addArc(withCenter: .init(x: rect.minX + radius, y: rect.maxY - radius), radius: radius, startAngle: -.pi, endAngle: -.pi.half * 3, clockwise: false)
		path.close()
		
		let shapeLayer = CAShapeLayer()
		shapeLayer.path = path.cgPath
		shapeLayer.fillColor = color.cgColor
		
		addSublayer(shapeLayer)
	}
}

