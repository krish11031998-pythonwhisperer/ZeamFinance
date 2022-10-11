//
//  MultipleStrokeProgressBar.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 10/10/2022.
//

import Foundation
import UIKit

struct MultipleStrokeModel {
	let color: UIColor
	let name: RenderableText
	let val: Float
	init(color: UIColor, name: RenderableText, val: Float) {
		self.color = color
		self.name = name
		self.val = val
	}
	
	init(color: UIColor, nameText: String, val: Float) {
		self.color = color
		self.name = nameText.medium(size: 12)
		self.val = val
	}
}

class MultipleStrokeProgressBar: UIView {
	
	private lazy var strokeLayers: [CAShapeLayer] = []
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		border(color: .surfaceBackgroundInverse, borderWidth: 0.5, cornerRadius: 12)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		border(color: .surfaceBackgroundInverse, borderWidth: 0.5, cornerRadius: 12)
	}
	
	private func buildLayer(_ model: MultipleStrokeModel) {
		let shape = CAShapeLayer()
		let path = UIBezierPath(roundedRect: .init(origin: bounds.origin, size: .init(width: 1, height: bounds.height)),
								cornerRadius: 0)
		shape.path = path.cgPath
		shape.fillColor = model.color.cgColor
		layer.addSublayer(shape)
		strokeLayers.append(shape)
	}
	
	public func configureProgressBar(ratios model: [MultipleStrokeModel]) {
		guard let sortedModel = try? model.sorted(by: { $0.val < $1.val }) else { return }
		if !strokeLayers.isEmpty {
			strokeLayers.forEach { $0.removeFromSuperlayer() }
			strokeLayers.removeAll()
		}
		sortedModel.forEach(buildLayer(_:))
		let vals = sortedModel.compactMap { $0.val }
		var computerVals: [CGFloat] = [1]
		vals.forEach {
			if $0 != vals.last {
				computerVals.append(computerVals.last! - CGFloat($0))
			}
		}
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			for (strokeLayer, layerData) in zip(self.strokeLayers,computerVals) {
				strokeLayer.animate(animation: .progress(to: layerData * self.bounds.width))
			}
		}
	}
	
	
}
