//
//  Animation.swift
//  SignalMVP
//
//  Created by Krishna Venkatramani on 23/09/2022.
//

import Foundation
import UIKit

enum Animation {
	case bouncy(duration: CFTimeInterval = 0.3)
	case slideInFromTop(from: CGFloat, to:CGFloat = 0, duration: CFTimeInterval)
	case circularProgress(from: CGFloat = 0, to: CGFloat, duration: CFTimeInterval)
}

extension Animation {
	
	func animation(at layer: CALayer) -> CAAnimation {
		
		switch self {
		case .bouncy(let duration):
			let animation = CABasicAnimation(keyPath: "transform.scale")
			animation.toValue = 0.95
			animation.duration = duration
			animation.isRemovedOnCompletion = true
			return animation
		case .slideInFromTop(let from, let to, let duration):
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.fromValue = from
			animation.toValue = to

			let opacity = CABasicAnimation(keyPath: "opacity")
			opacity.fromValue = 0
			opacity.toValue = 1

			
			let group = CAAnimationGroup()
			group.animations = [animation, opacity]
			group.fillMode = .forwards
			group.isRemovedOnCompletion = false
			group.duration = duration
			
			return group
		case .circularProgress(let from, let to, let duration):
			let animation = CABasicAnimation(keyPath: "strokeEnd")
			animation.fromValue = from
			animation.toValue = to
			animation.duration = duration
			animation.isRemovedOnCompletion = false
			animation.fillMode = .forwards
			
			return animation
		}
		
	}
	
}

extension CALayer {
	
	func animate(animation: Animation, completion: Callback? = nil) {
		
		CATransaction.begin()
		
		if let completion = completion {
			CATransaction.setCompletionBlock(completion)
		}
		
		add(animation.animation(at: self), forKey: nil)
		
		CATransaction.commit()
	}
	
}
