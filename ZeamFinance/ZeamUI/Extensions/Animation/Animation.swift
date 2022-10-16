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
	case slideIn(from: CGFloat, to:CGFloat = 0, show: Bool = true, duration: CFTimeInterval = 0.33)
	case circularProgress(from: CGFloat = 0, to: CGFloat, duration: CFTimeInterval = 0.33)
	case progress(cornerRadius: CGFloat = 0, to: CGFloat, duration: CFTimeInterval = 0.33)
}

extension Animation {
	
	func animation(at layer: CALayer) -> CAAnimation {
		
		switch self {
		case .bouncy(let duration):
			let animation = CAKeyframeAnimation(keyPath: "transform.scale")
			animation.keyTimes = [0, 0.25, 0.5, 0.75, 1]
			animation.values = [1, 0.975 , 0.95, 0.975, 1]
			animation.duration = duration
			animation.isRemovedOnCompletion = true
			return animation
		case .slideIn(let from, let to, let show, let duration):
			let animation = CABasicAnimation(keyPath: "position.y")
			animation.fromValue = from
			animation.toValue = to

			let opacity = CABasicAnimation(keyPath: "opacity")
			opacity.fromValue = show ? 0 : 1
			opacity.toValue = show ? 1 : 0

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
		case .progress(let cornerRadius, let to, let duration):
			let animation = CABasicAnimation(keyPath: "path")
			let newpath = UIBezierPath(roundedRect: .init(origin: .zero, size: .init(width: to, height: layer.superlayer?.bounds.height ?? layer.bounds.height)),
									   cornerRadius: cornerRadius).cgPath
			animation.toValue = newpath
			animation.isRemovedOnCompletion = false
			animation.duration = duration
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
