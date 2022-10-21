//
//  CGPoint.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 10/10/2022.
//

import Foundation
import UIKit

extension CGPoint{
	
	static func - (lhs:CGPoint,rhs:CGPoint) -> CGPoint{
		return .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
	}
}

extension Array where Element == CGPoint{
	
	func findNearestPoint(_ location:CGPoint) -> CGPoint?{
		if isEmpty { return nil }
		
		var target:CGPoint? = first
		var min:CGFloat = CGFloat(Float.greatestFiniteMagnitude)
		
		for point in self{
			let diff = abs(point.x - location.x)
			if diff < min{
				min = diff
				target = point
			}
		}
		
		return target
	}
	
}


