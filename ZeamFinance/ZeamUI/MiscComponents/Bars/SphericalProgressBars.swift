//
//  SphericalProgressBars.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 06/10/2022.
//

import Foundation
import UIKit

class SphericalProgressBars: UIView {
	
	private var lineWidth: CGFloat
	private var scoreLabel: UILabel = { .init() }()
	private var scoreIndicator: UILabel = { .init() }()
	private var chartShape: CAShapeLayer?
	private var indicatorShape: CAShapeLayer?
	private lazy var scoreView: UIStackView = {
		let stack = UIStackView.VStack(subViews: [scoreLabel, scoreIndicator], spacing: 4, alignment: .center)
		stack.backgroundColor = .clear
		return stack
	}()
	private lazy var colorBG: UIView = { .init() }()
	private lazy var indicator: UIView = { .init() }()
	init(frame: CGRect, lineWidth: CGFloat) {
		self.lineWidth = lineWidth
		super.init(frame: frame)
		setupViews()
	}
	
	required init?(coder: NSCoder) {
		self.lineWidth = 0
		super.init(coder: coder)
		setupViews()
	}
	
	private func setupViews() {
		let width = 2 * (bounds.width.half - lineWidth - 10)
		colorBG = UIView()
		colorBG.backgroundColor = userInterface == .light ? .popWhite300 : .popBlack300
		colorBG.cornerRadius = width.half
		addSubview(colorBG)
		setFittingConstraints(childView: colorBG, width: width,
							  height: width, centerX: 0, centerY: 0)
		addSubview(scoreView)
		setFittingConstraints(childView: scoreView, width: 40, height: 40, centerX: 0, centerY: 0)
		indicator.setFrame(.init(squared: 6))
	}
	
	private func color(score: Int) -> UIColor {
		switch score {
		case 0..<300 :
			return .error500
		case 300..<600:
			return .warning500
		case 600..<900:
			return .success500
		default:
			return .clear
		}
	}
	
	private func scoreIndicator(_ score: Int) -> RenderableText {
		switch score {
		case 0..<300 :
			return "Bad".bold(color: color(score: score), size: 8)
		case 300..<600:
			return "Average".bold(color: color(score: score), size: 8)
		case 600..<900:
			return "Good".bold(color: color(score: score), size: 8)
		default:
			return "None".bold(color: color(score: score), size: 8)
		}
	}
	
	private func addCircularBar(_ score: Int) {
		if chartShape != nil {
			chartShape?.removeFromSuperlayer()
		}
		chartShape = layer.addCircularProgress(startAngle: .pi * 0.67,
								  endAngle: .pi * 0.33,
								  radiusOffset: -lineWidth,
								  lineWidth: lineWidth,
								  strokeColor: color(score: score),
								  clockwise: true,
								  animateStrokeEnd: true)
		border(color: .popBlack100, borderWidth: 1, cornerRadius: min(bounds.width, bounds.height).half)
	}
	
	public func configureView(_ score: Int) {
		addCircularBar(score)
		"\(score)".bold(color: .textColor, size: 16).render(target: scoreLabel)
		scoreIndicator(score).render(target: scoreIndicator)
		DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
			self.chartShape?.animate(animation: .circularProgress(to: CGFloat(score)/900.0, duration: 1))
		}
	}
	
	override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
		colorBG.backgroundColor = userInterface == .light ? .popWhite300 : .popBlack300
	}
	
}
