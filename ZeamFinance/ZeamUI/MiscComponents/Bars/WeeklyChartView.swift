//
//  WeeklyChart.swift
//  ZeamFinance
//
//  Created by Krishna Venkatramani on 12/10/2022.
//

import Foundation
import UIKit

fileprivate extension TransactionWeeklyModel {
	
	var normalizedHeight: [CGFloat] {
		daily.compactMap{_ in CGFloat(Float.random(in: 100..<1000)) }.normalize(fromZero: true)
	}
}


class WeeklyChartView: UIView {
	
	private let innerStackInset: CGFloat = 15
	private let indicatorWidth: CGFloat = 10
	private lazy var stack: UIStackView = { .HStack(spacing: 0, alignment: .center) }()
	private lazy var mainStack: UIStackView = { .VStack(spacing: 10) }()
	let dayStack: UIStackView = {
		let view = UIStackView.HStack(spacing: 10)
		view.distribution = .equalSpacing
		Array(repeating: "Mon 22", count: 7).map {
			let label = $0.medium(size: 12).generateLabel
			label.numberOfLines = 2
			label.textAlignment = .center
			return label
		}.addToView(view)
		return view
	}()
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupView()
	}
	
	private func setupView() {
		[stack, dayStack].addToView(mainStack)
		addSubview(mainStack)
		stack.distribution = .equalSpacing
		setFittingConstraints(childView: mainStack, insets: .init(by: innerStackInset), priority: .needed)
		addBackgroundView()
	}
	
	private func addBackgroundView() {
		let view = UIView()
		view.backgroundColor = userInterface == .dark ? .popBlack300 : .popWhite300
		insertSubview(view, at: 0)
		setFittingConstraints(childView: view, insets: .init(by: 0), priority: .needed)
		view.clippedCornerRadius = 8
	}
	
	public func configureChart(_ weekly: TransactionWeeklyModel) {
		//
		stack.removeChildViews()
		let stackHeight = frame.height - 2 * (innerStackInset + dayStack.compressedSize.height) - 10
		weekly.normalizedHeight.compactMap { $0 * stackHeight }.forEach { h in
			let size: CGSize = .init(width: indicatorWidth, height: h)
			let lineView = UIView()
			lineView.backgroundColor = .popBlack100
			let view = UIView()
			view.backgroundColor = .surfaceBackgroundInverse
			view.setFrame(size)
			view.circleFrame = size.frame
			let chartIndicator = UIView()
			[lineView, view].forEach {
				chartIndicator.addSubview($0)
			}
			chartIndicator.setFittingConstraints(childView: view, centerY: 0)
			chartIndicator.setFittingConstraints(childView: lineView,top: 0, bottom: 0, width: 0.5, centerX: 0)
			chartIndicator.setFrame(width: indicatorWidth, height: stackHeight)
			stack.addArrangedSubview(chartIndicator.embedInView(insets: .init(vertical: 0, horizontal: indicatorWidth)))
		}
	}
}
