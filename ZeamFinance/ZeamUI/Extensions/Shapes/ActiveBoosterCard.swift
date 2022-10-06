//
//  ActiveBoosterCard.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 05/10/2022.
//

import Foundation
import UIKit


extension CALayer {
	
	func addboosterShape(color: UIColor = .clear, curvePoint: CGFloat, borderColor: UIColor) {
		let rect = bounds
		let path = UIBezierPath()
		path.move(to: .init(x: rect.minX, y: curvePoint))
		path.addArc(withCenter: .init(x: rect.midX, y: curvePoint), radius: rect.width.half, startAngle: -.pi, endAngle: .zero, clockwise: true)
		path.addLine(to: .init(x: rect.maxX, y: rect.maxY))
		path.addLine(to: .init(x: rect.minX, y: rect.maxY))
		path.close()
		
		let shape = CAShapeLayer()
		shape.path = path.cgPath
		shape.fillColor = color.cgColor
		shape.strokeColor = borderColor.cgColor
		shape.lineWidth = 2
		
		addSublayer(shape)
	}
	
}

