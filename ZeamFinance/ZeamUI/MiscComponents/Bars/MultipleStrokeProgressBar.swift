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


//MARK: - MultipleStrokeProgressBarAlt

class MultipleStrokeProgressBarAlt: UIView {
    
    private var bars: [ProgressBar] = []
    private lazy var stack: UIStackView = { .HStack(spacing: 5, alignment: .center) }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        addSubview(stack)
        setFittingConstraints(childView: stack, insets: .zero)
    }
    
    private func buildLayer(_ model: MultipleStrokeModel, _ total: Float) {
        let width = CGFloat(model.val) * frame.width/CGFloat(total)
        let bar = ProgressBar(fillColor: model.color, borderColor: .popBlack300)
        bar.setFrame(width: width - stack.spacing, height: frame.height)
        bars.append(bar)
    }
    
    public func configureProgressBar(ratios model: [MultipleStrokeModel]) {
        guard let sortedModel = try? model.sorted(by: { $0.val > $1.val }) else { return }
        if !bars.isEmpty {
            stack.removeChildViews()
            bars.removeAll()
        }
        let total = model.reduce(0,  { $0 + $1.val })
        sortedModel.forEach {
            buildLayer($0, total)
        }
        bars.addToView(stack)
        bars.animateSequentially(ratios: Array(repeating: 1, count: bars.count))
    }
    
    
}
